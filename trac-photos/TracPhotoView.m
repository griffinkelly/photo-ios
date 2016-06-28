//
//  TracPhotoView.m
//  trac-photos
//
//  Created by Nick Schulze on 6/3/16.
//  Copyright © 2016 TRAC. All rights reserved.
//

#import "TracPhotoView.h"

@implementation TracPhotoView

@synthesize delegate;

-(id)init
{
    UIScreen* main = [UIScreen mainScreen];
    width = main.bounds.size.width;
    
    self = [super initWithFrame:CGRectMake(10, 0, width-20, width-20)];
    if (self)
    {
        [self setBackgroundColor:[UIColor white]];
        self.layer.cornerRadius = 5;
        
        image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, width-40, (width-40)*.8)];
        image.backgroundColor = [UIColor yellow];
        image.layer.cornerRadius = 5;
//        [image setImage:[UIImage imageNamed:@"tyler.jpg"]];
        image.layer.masksToBounds = YES;
        image.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:image];
        
        profile = [[UIImageView alloc] initWithFrame:CGRectMake(10, (width-40)*.86, (width-40)*.15, (width-40)*.15)];
        profile.backgroundColor = [UIColor lightBlue];
        profile.layer.cornerRadius = ((width-40)*.15)/2;
        profile.layer.masksToBounds = YES;
        profile.contentMode = UIViewContentModeScaleAspectFill;
        [profile setImage:[UIImage imageNamed:@"photo.jpg"]];
        profile.layer.borderWidth = 2;
        profile.layer.borderColor = [UIColor blue].CGColor;
//        [self addSubview:profile];
        
        description = [[UITextView alloc] initWithFrame:CGRectMake(15+(width-40)*.15, (width-40)*.86, width-40-(width-40)*.15, (width-40)*.15)];
        description.backgroundColor = [UIColor clearColor];
        [description setText:@"Tyler finishing the marathon with a personal best time of 2:16:34"];
        [description setUserInteractionEnabled:NO];
        [description setFont:[UIFont fontWithName:@"Helvetica-Light" size:16.0]];
        [description setTextColor:[UIColor black]];
//        [self addSubview:description];
        
        time = [[UILabel alloc] initWithFrame:CGRectMake(10, (width-20)*.95, width-40, (width-40)*.04)];
        time.backgroundColor = [UIColor clearColor];
        [time setText:@"Grandma's Marathon on May 26, 2016 at 11:34 am."];
        [time setUserInteractionEnabled:NO];
        [time setFont:[UIFont fontWithName:@"Helvetica-Light" size:12.0]];
        [time setTextColor:[UIColor lightGrayColor]];
        [time setTextAlignment:NSTextAlignmentRight];
//        [self addSubview:time];
        
        tap = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width-20, width-20)];
        [tap addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tap];
    }
    return self;
}

-(void)fillWith:(TracPhoto*)photo
{
    if  (photo != nil && [photo url] != nil && ![[photo url] isEqual:[NSNull null]])
    {
        dispatch_async(dispatch_queue_create("photos", 0), ^{
            UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[photo url]]]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [image setImage:downloadedImage];
            });
        });
    }
}

-(void)tap
{
    [[self delegate] tapImage:image.image];
}

-(void)shift:(int)i
{
    self.center = CGPointMake(width/2, 10+(width-20)/2+((width-10)*i));
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
