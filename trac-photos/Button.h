//
//  Button.h
//  trac
//
//  Created by Nick Schulze on 4/22/16.
//  Copyright © 2016 Nick Schulze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+trac.h"

@interface Button : UIButton
{
    UITextView* description;
}

-(id)initMainButton:(NSString*)title atY:(CGFloat)y;

-(id)initRegisterButton:(NSString*)title atY:(CGFloat)y;

-(id)initSecondaryButton:(NSString*)title atY:(CGFloat)y;

-(id)initTertiaryButton:(NSString*)title atY:(CGFloat)y;

-(id)initActivityDashboardButton:(NSString*)title atY:(CGFloat)y;

-(id)initHeaderTextButton:(NSString*)title atX:(CGFloat)x atY:(CGFloat)y;

-(id)initRowTextButton:(NSString*)title atY:(CGFloat)y;

-(void)halfButtonAtX:(CGFloat)x;

-(void)halfButtonAtX:(CGFloat)x forWidth:(CGFloat)width;

-(void)setDescription:(NSString*)_description;

-(void)setCenter:(CGPoint)center;

@end
