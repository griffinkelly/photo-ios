//
//  TracAPI.h
//  trac-photos
//
//  Created by Nick Schulze on 6/12/16.
//  Copyright © 2016 TRAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TracAccount.h"
#import "TracRace.h"
#import "TracPhoto.h"
#import "SBJson.h"
#import "SSKeychain.h"
#import "AFURLSessionManager.h"

@interface TracAPI : NSObject

+(TracAccount*)loggedIn;

+(TracAccount*)tracRegister:(NSString*)name email:(NSString*)email password:(NSString*)password;

+(TracAccount*)tracLogin:(NSString*)email password:(NSString*)password;

+(void)logout;

+(NSMutableArray*)racesForPage:(int)page;

+(NSMutableArray*)photosForRace:(int)race atPage:(int)page;

+(NSMutableArray*)athleteForRace:(int)race withBib:(int)bib andPage:(int)page;
+(NSMutableArray*)photosForPage:(int)page;

+(NSMutableArray*)userPhotosForPage:(int)page;

+(NSString*)createPhoto:(NSData*)imageData session:(int)session;
@end
