//
//  Trac.h
//  trac-photos
//
//  Created by Nick Schulze on 6/12/16.
//  Copyright © 2016 TRAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TracAPI.h"

@class Trac;
@protocol TracDelegate <NSObject>

@optional
@required
- (void)login:(TracAccount*) account;
- (void)logout;
- (void)addToMain:(NSMutableArray*) all;
- (void)addToRaces:(NSMutableArray*) races;
- (void)addToRacePhotos:(NSMutableArray*) photos;
- (void)addToAthletePhotos:(NSMutableArray*) photos;
- (void)addToUserPhotos:(NSMutableArray*) photos;
- (void)createdPhoto:(NSString*) success;

@end

@interface Trac : NSObject
{
    NSString* currentFilter;
    int raceId;
    int bibNum;
}

@property (nonatomic, retain) id <TracDelegate> delegate;

-(TracAccount*)loggedIn;

-(void)tracRegister:(NSString*)name email:(NSString*)email password:(NSString*)password;

-(void)tracLogin:(NSString*)email password:(NSString*)password;

- (void)logout;

-(void)loadMore:(int)amount;

-(void)racesForPage:(int)page;

-(void)photosForRace:(int)race atPage:(int)page;

-(void)athleteForRace:(int)race withBib:(int)bib andPage:(int)page;

-(void)photosForPage:(int)page;

-(void)userPhotosForPage:(int)page;

-(void)createPhoto:(NSData*)imageData session:(int)session;

-(void)setRaceId:(int)_raceId;

@end


//http://104.155.178.106/api/sessions/ --A list of races

//http://104.155.178.106/api/sessions/1/photographs/

//http://104.155.178.106/api/sessions/1/athletes/?bib={bib#}

//http://104.155.178.106/api/photos
//If you post to this you gotta post like {photo: the file, ts: {pk of the session}}