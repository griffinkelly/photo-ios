//
//  TracAPI.m
//  trac-photos
//
//  Created by Nick Schulze on 6/12/16.
//  Copyright © 2016 TRAC. All rights reserved.
//

#import "TracAPI.h"

@implementation TracAPI

NSString* api_url = @"http://tracfoto.com/api/";
NSString* token = @"";

+(TracAccount*)loggedIn
{
    NSString* storedToken = [SSKeychain passwordForService:@"token" account:@"trac"];
    
    TracAccount* tracAccount = [[TracAccount alloc] init];
    if ([storedToken isEqualToString:@""] || storedToken == nil)
    {
        [tracAccount setName:@"invalid"];
        return tracAccount;
    }
    else
    {
        token = storedToken;
        [tracAccount setName:[SSKeychain passwordForService:@"name" account:@"trac"]];
        [tracAccount setEmail:[SSKeychain passwordForService:@"email" account:@"trac"]];
        
        return tracAccount;
    }
}

+(TracAccount*)tracRegister:(NSString*)name email:(NSString*)email password:(NSString*)password
{  
    NSString *post =[[NSString alloc] initWithFormat:@"username=%@&password=%@&email=%@&user_type=photographer", name, password ,email];
    NSString* url = [NSString stringWithFormat:@"%@%@", api_url, @"register/"];
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    [request setHTTPShouldHandleCookies:NO];
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    
    NSData *result = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    
    NSDictionary *dictionary = [TracAPI generateSBJsonDictionaryWithData:result];
    
    TracAccount* tracAccount = [[TracAccount alloc] init];
    
    if (requestError == nil)
    {
        [tracAccount setName:[[dictionary valueForKey:@"user"] valueForKey:@"username"]];
        [tracAccount setEmail:[[dictionary valueForKey:@"user"] valueForKey:@"email"]];
        [tracAccount setToken:[dictionary valueForKey:@"access_token"]];
        
        token = [dictionary valueForKey:@"access_token"];
        [SSKeychain setPassword:[tracAccount name] forService:@"name" account:@"trac"];
        [SSKeychain setPassword:[tracAccount name] forService:@"email" account:@"trac"];
        [SSKeychain setPassword:[tracAccount token] forService:@"token" account:@"trac"];
    }
    else
    {
        [tracAccount setName:@"invalid"];
    }
    return tracAccount;
}

+(TracAccount*)tracLogin:(NSString*)email password:(NSString*)password
{
    NSString *ios_client = @"cZZ3t7xBzyFc3u5DP1yjQZ13a9UjqGYtMJluwQYb";
    NSString *post =[[NSString alloc] initWithFormat:@"username=%@&password=%@&client_id=%@&grant_type=password", email,password,ios_client];
    NSString* url = [NSString stringWithFormat:@"%@%@", api_url, @"login/"];
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    [request setHTTPShouldHandleCookies:NO];
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    
    NSData *result = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    
    NSDictionary *dictionary = [TracAPI generateSBJsonDictionaryWithData:result];
    
    TracAccount* tracAccount = [[TracAccount alloc] init];
    
    if (requestError == nil)
    {
        [tracAccount setName:[[dictionary valueForKey:@"user"] valueForKey:@"username"]];
        [tracAccount setEmail:[[dictionary valueForKey:@"user"] valueForKey:@"email"]];
        [tracAccount setToken:[dictionary valueForKey:@"access_token"]];
        
        token = [dictionary valueForKey:@"access_token"];
        [SSKeychain setPassword:[tracAccount name] forService:@"name" account:@"trac"];
        [SSKeychain setPassword:[tracAccount name] forService:@"email" account:@"trac"];
        [SSKeychain setPassword:[tracAccount token] forService:@"token" account:@"trac"];
    }
    else
    {
        [tracAccount setName:@"invalid"];
    }
    return tracAccount;
}

+(void)logout
{
    [SSKeychain setPassword:@"" forService:@"name" account:@"trac"];
    [SSKeychain setPassword:@"" forService:@"email" account:@"trac"];
    [SSKeychain setPassword:@"" forService:@"token" account:@"trac"];
}

+(NSMutableArray*)racesForPage:(int)page
{
    NSString* url = [NSString stringWithFormat:@"%@sessions", api_url];
    
    NSArray* response = [TracAPI makeGetRequest:url];
    if ([response count] > 0)
    {
        NSData *result = [response objectAtIndex:0];
        
        NSArray* raceItems = (NSArray*)[TracAPI generateSBJsonDictionaryWithData:result];
        
        NSMutableArray* results = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < [raceItems count]; i++)
        {
            NSDictionary* item = [raceItems objectAtIndex:i];
            TracRace* race = [[TracRace alloc] init];
            [race setIdentifier:[item valueForKey:@"id"]];
            [race setName:[item valueForKey:@"name"]];
            [race setCity:[item valueForKey:@"city"]];
            [race setState:[item valueForKey:@"state"]];
            [race setCountry:[item valueForKey:@"country"]];
            [race setLatitude:[item valueForKey:@"latitude"]];
            [race setLongitude:[item valueForKey:@"longitude"]];
            
            [results addObject:race];
        }
        
        return results;
    }
    else
    {
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Something weird happened..."
        //                                                        message:@"Make sure your internet is working. If weird stuff keeps happening, please let us know!"
        //                                                       delegate:nil
        //                                              cancelButtonTitle:@"OK"
        //                                              otherButtonTitles:nil];
        //        [alert show];
    }
    return nil;
}

+(NSMutableArray*)photosForRace:(int)race atPage:(int)page
{
    NSString* url = [NSString stringWithFormat:@"%@sessions/%d/photographs?offset=%d&limit=10", api_url, race, page];
    
    NSArray* response = [TracAPI makeGetRequest:url];
    if ([response count] > 0)
    {
        NSData *result = [response objectAtIndex:0];
        
        NSDictionary* dictionary = [TracAPI generateSBJsonDictionaryWithData:result];
        
        NSMutableArray* results = [[NSMutableArray alloc] init];
        
        NSArray* photoItems = [dictionary valueForKey:@"results"];
        
        for (int i = 0; i < [photoItems count]; i++)
        {
            NSDictionary* item = [photoItems objectAtIndex:i];
            TracPhoto* photo = [[TracPhoto alloc] init];
            [photo setTitle:[item valueForKey:@"title"]];
            [photo setDescription:[item valueForKey:@"description"]];
            [photo setCreated_at:[item valueForKey:@"created_at"]];
            [photo setUrl:[item valueForKey:@"photo"]];
            [photo setScaled_url:[item valueForKey:@"scaled_url"]];
            
            [results addObject:photo];
        }
        
        return results;
    }
    else
    {
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Something weird happened..."
        //                                                        message:@"Make sure your internet is working. If weird stuff keeps happening, please let us know!"
        //                                                       delegate:nil
        //                                              cancelButtonTitle:@"OK"
        //                                              otherButtonTitles:nil];
        //        [alert show];
    }
    return nil;
}

+(NSMutableArray*)athleteForRace:(int)race withBib:(int)bib andPage:(int)page
{
    NSString* url = [NSString stringWithFormat:@"%@sessions/%d/athletes?offset=%d&limit=10&bib=%d", api_url, race, page, bib];
    NSArray* response = [TracAPI makeGetRequest:url];
    if ([response count] > 0)
    {
        NSData *result = [response objectAtIndex:0];
        
        NSDictionary* dictionary = [TracAPI generateSBJsonDictionaryWithData:result];
        
        NSMutableArray* results = [[NSMutableArray alloc] init];
        
        NSArray* photoItems = [dictionary valueForKey:@"results"];
        
        for (int i = 0; i < [photoItems count]; i++)
        {
            NSDictionary* item = [photoItems objectAtIndex:i];
            TracPhoto* photo = [[TracPhoto alloc] init];
            [photo setTitle:[item valueForKey:@"title"]];
            [photo setDescription:[item valueForKey:@"description"]];
            [photo setCreated_at:[item valueForKey:@"created_at"]];
            [photo setUrl:[item valueForKey:@"watermark"]];
            [photo setScaled_url:[item valueForKey:@"scaled_url"]];
            
            [results addObject:photo];
        }
        
        return results;
    }
    else
    {
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Something weird happened..."
        //                                                        message:@"Make sure your internet is working. If weird stuff keeps happening, please let us know!"
        //                                                       delegate:nil
        //                                              cancelButtonTitle:@"OK"
        //                                              otherButtonTitles:nil];
        //        [alert show];
    }
    return nil;
}

+(NSMutableArray*)photosForPage:(int)page
{
    NSString* url = [NSString stringWithFormat:@"%@photos/?access_token=%@&offset=%d&limit=10", api_url, token, page];
    
    NSArray* response = [TracAPI makeGetRequest:url];
    if ([response count] > 0)
    {
        NSData *result = [response objectAtIndex:0];
        
        NSDictionary* dictionary = [TracAPI generateSBJsonDictionaryWithData:result];
        
        NSMutableArray* results = [[NSMutableArray alloc] init];
        
        NSArray* photoItems = [dictionary valueForKey:@"results"];
        
        for (int i = 0; i < [photoItems count]; i++)
        {
            NSDictionary* item = [photoItems objectAtIndex:i];
            TracPhoto* photo = [[TracPhoto alloc] init];
            [photo setTitle:[item valueForKey:@"title"]];
            [photo setDescription:[item valueForKey:@"description"]];
            [photo setCreated_at:[item valueForKey:@"created_at"]];
            [photo setUrl:[item valueForKey:@"watermark"]];
            [photo setScaled_url:[item valueForKey:@"thumbnail"]];
            
            [results addObject:photo];
        }
        
        return results;
    }
    else
    {
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Something weird happened..."
        //                                                        message:@"Make sure your internet is working. If weird stuff keeps happening, please let us know!"
        //                                                       delegate:nil
        //                                              cancelButtonTitle:@"OK"
        //                                              otherButtonTitles:nil];
        //        [alert show];
    }
    return nil;
}

+(NSMutableArray*)userPhotosForPage:(int)page
{
    NSString* url = [NSString stringWithFormat:@"%@photos/?access_token=%@&offset=%d&limit=10", api_url, token, page];
    
    NSArray* response = [TracAPI makeGetRequest:url];
    if ([response count] > 0)
    {
        NSData *result = [response objectAtIndex:0];
        
        NSDictionary* dictionary = [TracAPI generateSBJsonDictionaryWithData:result];
        
        NSMutableArray* results = [[NSMutableArray alloc] init];
        
        NSArray* photoItems = [dictionary valueForKey:@"results"];
        
        for (int i = 0; i < [photoItems count]; i++)
        {
            NSDictionary* item = [photoItems objectAtIndex:i];
            TracPhoto* photo = [[TracPhoto alloc] init];
            [photo setTitle:[item valueForKey:@"title"]];
            [photo setDescription:[item valueForKey:@"description"]];
            [photo setCreated_at:[item valueForKey:@"created_at"]];
            [photo setUrl:[item valueForKey:@"url"]];
            [photo setScaled_url:[item valueForKey:@"scaled_url"]];
            
            [results addObject:photo];
        }
        
        return results;
    }
    else
    {
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Something weird happened..."
        //                                                        message:@"Make sure your internet is working. If weird stuff keeps happening, please let us know!"
        //                                                       delegate:nil
        //                                              cancelButtonTitle:@"OK"
        //                                              otherButtonTitles:nil];
        //        [alert show];
    }
    return nil;
}

+(NSString*)createPhoto:(NSData*)imageData session:(int)session
{
    NSString *method = @"POST";
    NSString *url = [NSString stringWithFormat:@"http://tracfoto.com/api/photos/?access_token=%@", token];
    NSString* ts = [NSString stringWithFormat:@"%d", session];
    NSDictionary *parameters = @{@"ts": ts};
    NSError *error;
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer]
                                    multipartFormRequestWithMethod:method
                                    URLString:url
                                    parameters:parameters
                                    constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                                        [formData appendPartWithFileData:imageData name:@"photo" fileName:@"test.jpg" mimeType:@"image/jpeg"];
                                    }
                                    error:&error];
    [request setTimeoutInterval:15];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFJSONResponseSerializer
                                  serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:nil
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          NSLog( @"invalid");
                      } else {
                          NSLog(@"success");
                      }
                  }];
    
    [uploadTask resume];
    return @"";
}

+(NSDictionary*)generateSBJsonDictionaryWithData:(NSData*)data
{
    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    
    NSDictionary* results = [parser objectWithString:dataString];
    
    return results;
}

+(NSArray*)generateDictionaryWithData:(NSData*)data
{
    NSError* error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    NSArray* streams = [json valueForKey:@"items"];
    
    return streams;
}

+(NSArray*)makeGetRequest:(NSString*)url
{
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPMethod: @"GET"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    
    NSData *result = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    
    NSArray* response = [[NSArray alloc] initWithObjects:result, requestError, nil];
    
    return response;
}

+(NSData*)makePostRequest:(NSString*)url postString:(NSString*)postString
{
    NSData* data = [postString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    [request setTimeoutInterval: 60000];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPMethod: @"POST"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPBody:data];
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    
    NSData *result = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    
    return result;
}

@end
