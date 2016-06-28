//
//  LoginViewController.h
//  trac
//
//  Created by Nick Schulze on 4/22/16.
//  Copyright © 2016 Nick Schulze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+trac.h"
#import "Button.h"
#import "Label.h"
#import "TextField.h"
#import "Trac.h"

@interface LoginViewController : UIViewController
{
    CGFloat width;
    CGFloat height;
    
    UIImageView* image;
    Button* loginButton;
    Button* registerButton;
    TextField* email;
    TextField* password;
    
    UILabel* registerTitle;
    UIView* registerView;
    UIScrollView* registerScroll;
    UIImageView* registerImage;
    Button* registerSubmitButton;
    TextField* registerName;
    TextField* registerEmail;
    TextField* registerPassword;
    
    Trac* trac;
}

-(void)invalidLogin;

-(void)injectTrac:(Trac*)_trac;

-(void)moveIn;

-(void)moveOut;

@end
