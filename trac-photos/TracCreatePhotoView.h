//
//  TracCreatePhotoView.h
//  trac-photos
//
//  Created by Nick Schulze on 6/14/16.
//  Copyright © 2016 TRAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+trac.h"
#import "TracRaceButton.h"

@class TracCreatePhotoView;
@protocol TracCreateDelegate <NSObject>

@optional
@required
- (void)createImage:(UIImage*)img;
- (void)createdPhoto;
@end

@interface TracCreatePhotoView : UIView <TracRaceDelegate>
{
    CGFloat width;
    
    UIImageView* image;
    UIImageView* profile;
    UIButton* location;
    UIButton* locationText;
    UILabel* time;
    UITextView* description;
    UIButton* createImage;
    UIButton* cancel;
    UIButton* changeLocation;
    Trac* trac;
    TracRaceButton* button;
    TracRace* race;
    NSData* imageData;
    NSMutableArray* races;
    UIView* racesPopout;
    UIScrollView* raceScroll;
}

@property (nonatomic, retain) id <TracCreateDelegate> delegate;

-(void)fillWith:(UIImage*)img;

-(void)addData:(NSData*)imgData;

-(void)setRace:(TracRace*)_race;

-(void)addToRaces:(NSMutableArray*)_races;

-(void)injectTrac:(Trac*)_trac;

-(void)moveIn;

-(void)moveOut;

@end
