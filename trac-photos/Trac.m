//
//  Trac.m
//  trac-photos
//
//  Created by Nick Schulze on 6/12/16.
//  Copyright © 2016 TRAC. All rights reserved.
//

#import "Trac.h"

@implementation Trac

@synthesize delegate;

-(TracAccount*)loggedIn
{
    TracAccount* account = [TracAPI loggedIn];
    if (![[account name] isEqualToString:@"invalid"])
    {
        [self photosForPage:0];
        [self racesForPage:0];
    }
    return account;
}

-(void)tracRegister:(NSString*)name email:(NSString*)email password:(NSString*)password
{
    TracAccount* account = [TracAPI tracRegister:name email:email password:password];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self delegate] login:account];
        [self photosForPage:0];
        [self racesForPage:0];
    });
}

-(void)tracLogin:(NSString*)email password:(NSString*)password
{
    TracAccount* account = [TracAPI tracLogin:email password:password];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self delegate] login:account];
        [self photosForPage:0];
        [self racesForPage:0];
    });
}

-(void)logout
{
    [TracAPI logout];
    [[self delegate] logout];
}

-(void)loadMore:(int)amount
{
    if ([currentFilter isEqualToString:@"race"])
    {
        [self photosForRace:raceId atPage:amount];
    }
    else if([currentFilter isEqualToString:@"bib"])
    {
        [self athleteForRace:raceId withBib:bibNum andPage:amount];
    }
    else
    {
        [self userPhotosForPage:amount];
    }
}

-(void)racesForPage:(int)page
{
    dispatch_async(dispatch_queue_create("races", 0), ^{
        NSMutableArray* races = [TracAPI racesForPage:page];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[self delegate] addToRaces:races];
        });
    });
}

-(void)photosForRace:(int)race atPage:(int)page
{
    raceId = race;
    currentFilter = @"race";
    
    dispatch_async(dispatch_queue_create("photos", 0), ^{
        NSMutableArray* photos = [TracAPI photosForRace:race atPage:page];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[self delegate] addToRacePhotos:photos];
        });
    });
}

-(void)athleteForRace:(int)race withBib:(int)bib andPage:(int)page
{
    raceId = race;
    bibNum = bib;
    currentFilter = @"bib";
    
    dispatch_async(dispatch_queue_create("photos", 0), ^{
        NSMutableArray* photos = [TracAPI athleteForRace:race withBib:bib andPage:page];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[self delegate] addToAthletePhotos:photos];
        });
    });
}

-(void)photosForPage:(int)page
{
    currentFilter = @"user";

    dispatch_async(dispatch_queue_create("photos", 0), ^{
        NSMutableArray* photos = [TracAPI photosForPage:page];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[self delegate] addToMain:photos];
        });
    });
}

-(void)userPhotosForPage:(int)page
{
    currentFilter = @"user";

    dispatch_async(dispatch_queue_create("photos", 0), ^{
        NSMutableArray* photos = [TracAPI userPhotosForPage:page];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[self delegate] addToUserPhotos:photos];
        });
    });
}

-(void)createPhoto:(NSData*)imageData session:(int)session
{
    dispatch_async(dispatch_queue_create("photos", 0), ^{
        NSString* success = [TracAPI createPhoto:imageData session:raceId];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[self delegate] createdPhoto:success];
        });
    });
}

-(void)setRaceId:(int)_raceId
{
    raceId = _raceId;
}

@end
