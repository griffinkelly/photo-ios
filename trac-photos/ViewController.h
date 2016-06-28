//
//  ViewController.h
//  trac-photos
//
//  Created by Nick Schulze on 5/31/16.
//  Copyright © 2016 TRAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Trac.h"
#import "LoginViewController.h"
#import "MainViewController.h"
#import "ProfileViewController.h"
#import "SettingsViewController.h"

@interface ViewController : UIViewController <MainDelegate, ProfileDelegate, TracDelegate>
{
    Trac* trac;
    TracAccount* account;
    LoginViewController* login;
    MainViewController* main;
    ProfileViewController* profile;
    SettingsViewController* settings;
}

@end

