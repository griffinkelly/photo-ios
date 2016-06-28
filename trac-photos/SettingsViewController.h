//
//  SettingsViewController.h
//  trac
//
//  Created by Nick Schulze on 4/22/16.
//  Copyright © 2016 Nick Schulze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Label.h"
#import "Button.h"
#import "TextField.h"
#import "Trac.h"

@class SettingsViewController;
@protocol SettingsDelegate <NSObject>

@optional
@required
- (void)gotoTest:(int)i;

@end

@interface SettingsViewController : UIViewController
{
    CGFloat width;
    CGFloat height;
    
    UIScrollView* scroll;
    TextField* name;
    TextField* email;
    TextField* password;
    TextField* trainer;
    Button* notifications;
    Button* feedback;
    Button* logout;
    
    Trac* trac;
}

@property (nonatomic, retain) id <SettingsDelegate> delegate;

-(void)setTracAccount:(TracAccount*)tracAccount;

-(void)injectTrac:(Trac*)_trac;

-(void)moveIn;

@end
