//
//  TracPhotoView.h
//  trac-photos
//
//  Created by Nick Schulze on 6/3/16.
//  Copyright © 2016 TRAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+trac.h"
#import "TracPhoto.h"

@class TracPhotoView;
@protocol TapDelegate <NSObject>

@optional
@required
- (void)tapImage:(UIImage*)img;

@end

@interface TracPhotoView : UIView
{
    CGFloat width;
    
    UIImageView* image;
    UIImageView* profile;
    UIButton* location;
    UIButton* locationText;
    UILabel* time;
    UITextView* description;
    UIButton* tap;
}

@property (nonatomic, retain) id <TapDelegate> delegate;

-(void)fillWith:(TracPhoto*)photo;

-(void)shift:(int)i;

@end
