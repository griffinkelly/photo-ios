//
//  ProfileViewController.h
//  trac
//
//  Created by Nick Schulze on 5/7/16.
//  Copyright © 2016 Nick Schulze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+trac.h"
#import "Button.h"
#import "Trac.h"

@class ProfileViewController;
@protocol ProfileDelegate <NSObject>

@optional
@required
- (void)gotoSettings;
- (void)gotoMain;

@end

@interface ProfileViewController : UIViewController
{
    CGFloat width;
    CGFloat height;
    
    UILabel* email;
    UILabel* name;
    
    Trac* trac;
}

@property (nonatomic, retain) id <ProfileDelegate> delegate;

-(void)setTracAccount:(TracAccount*)tracAccount;

-(void)injectTrac:(Trac*)_trac;

-(void)moveIn;

@end
