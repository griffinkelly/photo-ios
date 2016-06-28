//
//  TracRaceButton.h
//  trac-photos
//
//  Created by Nick Schulze on 6/12/16.
//  Copyright © 2016 TRAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Trac.h"
#import "TracRace.h"
#import "UIColor+trac.h"

@class TracRaceButton;
@protocol TracRaceDelegate <NSObject>

@optional
@required
- (void)setRace:(TracRace*)_race;

@end

@interface TracRaceButton : UIView
{
    CGFloat buttonWidth;;
    Trac* trac;
    TracRace* race;
    
    UIButton* tap;
    UILabel* name;
}

@property (nonatomic, retain) id <TracRaceDelegate> delegate;

-(id)initWithTracRace:(TracRace*)_race;

-(id)initWithTracRaceForCreate:(TracRace*)_race;

-(CGFloat)buttonWidth;

-(void)shift:(CGFloat)buttonCursor;

-(void)shiftDown:(int)i;

@end
