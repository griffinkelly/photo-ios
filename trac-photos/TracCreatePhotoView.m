//
//  TracCreatePhotoView.m
//  trac-photos
//
//  Created by Nick Schulze on 6/14/16.
//  Copyright © 2016 TRAC. All rights reserved.
//

#import "TracCreatePhotoView.h"

@implementation TracCreatePhotoView

-(id)init
{
    UIScreen* main = [UIScreen mainScreen];
    width = main.bounds.size.width;
    
    self = [super initWithFrame:CGRectMake(10, 120, width-20, width+30)];
    if (self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
        self.layer.cornerRadius = 5;
        
        UIView* background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width-20, width-20)];
        background.backgroundColor = [UIColor white];
        background.layer.cornerRadius = 5;
        [self addSubview:background];
        
        image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, width-40, (width-40)*.8)];
        image.backgroundColor = [UIColor yellow];
        image.layer.cornerRadius = 5;
        //        [image setImage:[UIImage imageNamed:@"tyler.jpg"]];
        image.layer.masksToBounds = YES;
        image.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:image];
        
        createImage = [[UIButton alloc] initWithFrame:CGRectMake(10, width-10, width-40, 44)];
        createImage.backgroundColor = [UIColor blue];
        [createImage setTitle:@"Post Image" forState:UIControlStateNormal];
        createImage.layer.cornerRadius = 22;
        [createImage addTarget:self action:@selector(createImage) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:createImage];
        
        changeLocation = [[UIButton alloc] initWithFrame:CGRectMake(width-60, width-70, 30, 30)];
        changeLocation.backgroundColor = [UIColor blue];
        [changeLocation setTitle:@"X" forState:UIControlStateNormal];
        changeLocation.layer.cornerRadius = 15;
        [changeLocation addTarget:self action:@selector(cancelLocation) forControlEvents:UIControlEventTouchUpInside];
        changeLocation.hidden = YES;
        [self addSubview:changeLocation];
        
        racesPopout = [[UIView alloc] initWithFrame:CGRectMake((width-20)/2-110, 20, 220, 300)];
        racesPopout.backgroundColor = [UIColor blue];
        racesPopout.layer.cornerRadius = 5;
        racesPopout.layer.shadowColor = [UIColor darkGrayColor].CGColor;
        racesPopout.layer.shadowOffset = CGSizeMake(3, 3);
        racesPopout.layer.shadowOpacity = .7;
        racesPopout.hidden = YES;
        racesPopout.alpha = 0.0;
        [self addSubview:racesPopout];
        
        UILabel* raceName = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 220, 30)];
        [raceName setText:@"Race Locations"];
        [raceName setTextAlignment:NSTextAlignmentCenter];
        [raceName setFont:[UIFont fontWithName:@"Helvetica-Light" size:18.0]];
        [raceName setTextColor:[UIColor white]];
        [racesPopout addSubview:raceName];
        
        raceScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, 220, 260)];
        raceScroll.backgroundColor = [UIColor white];
        [racesPopout addSubview:raceScroll];
        
        self.alpha = 0.0;
    }
    return self;
}

-(void)fillWith:(UIImage*)img
{
    dispatch_async(dispatch_queue_create("photos", 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [image setImage:img];
        });
    });
}

-(void)addData:(NSData*)imgData
{
    imageData = imgData;
}

-(void)tap
{
    [[self delegate] createImage:image.image];
}

-(void)createImage
{
    [trac createPhoto:imageData session:[[race identifier] intValue]];
    [[self delegate] createdPhoto];
    [self moveOut];
}

-(void)setRace:(TracRace*)_race
{
    [trac setRaceId:[[_race identifier] intValue]];
    
    if (_race != nil)
    {
        [button removeFromSuperview];
        race = _race;
        button = [[TracRaceButton alloc] initWithTracRaceForCreate:race];
        button.center = CGPointMake((width-20)/2, width-60);
        changeLocation.hidden = NO;
        [self addSubview:button];
        
        [UIView animateWithDuration:.4
                         animations:^{
                             racesPopout.alpha = 0.0;
                             racesPopout.hidden = YES;
                         }];
    }
    else
    {
        racesPopout.hidden = NO;
        racesPopout.alpha = 1.0;
    }
}

-(void)cancelLocation
{
    [UIView animateWithDuration:.4
                     animations:^{
                         button.alpha = 0.0;
                         [button removeFromSuperview];
                         racesPopout.alpha = 1.0;
                         racesPopout.hidden = NO;
                     }];
}

-(void)addToRaces:(NSMutableArray*)_races
{
    races = _races;
    for (int i = 0; i < [races count]; i++)
    {
        TracRace* raceB = [races objectAtIndex:i];
        
        TracRaceButton* raceButton = [[TracRaceButton alloc] initWithTracRace:raceB];
        [raceButton shiftDown:i];
        [raceScroll addSubview:raceButton];
        [raceButton setDelegate:self];
    }
    
    raceScroll.contentSize = CGSizeMake(220, 44);
}

-(void)moveIn
{
    [self bringSubviewToFront:racesPopout];
    [UIView animateWithDuration:.4
                     animations:^{
                         self.alpha = 1.0;
                     }];
}

-(void)moveOut
{
    [UIView animateWithDuration:.4
                     animations:^{
                         self.alpha = 0.0;
                     }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
