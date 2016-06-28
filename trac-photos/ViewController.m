//
//  ViewController.m
//  trac-photos
//
//  Created by Nick Schulze on 5/31/16.
//  Copyright © 2016 TRAC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    trac = [[Trac alloc] init];
    [trac setDelegate:self];
    
    main = [[MainViewController alloc] init];
    [main setDelegate:self];
    [main injectTrac:trac];
    [self.view addSubview:main.view];
    
    profile = [[ProfileViewController alloc] init];
    [profile setDelegate:self];
    [profile injectTrac:trac];
    [self.view addSubview:profile.view];
    
    login = [[LoginViewController alloc] init];
    [login injectTrac:trac];
    [self.view addSubview:login.view];
    
    settings = [[SettingsViewController alloc] init];
    [settings injectTrac:trac];
    [self.view addSubview:settings.view];
    
    account = [trac loggedIn];
    if  (![[account name] isEqualToString:@"invalid"])
    {
        [profile setTracAccount:account];
        [settings setTracAccount:account];
        [login moveOut];
    }
}

- (void)login:(TracAccount*) _account
{
    account = _account;
    if ([[account name] isEqualToString:@"invalid"])
    {
        [login invalidLogin];
    }
    else
    {
        [profile setTracAccount:account];
        [settings setTracAccount:account];
        [login moveOut];
    }
}

- (void)logout
{
    [login moveIn];
    [main addToMain:nil];
}

- (void)addToMain:(NSMutableArray*) all
{
    [main addToMain:all];
}

- (void)addToRaces:(NSMutableArray*) races
{
    [main addToRaces:races];
}

- (void)addToRacePhotos:(NSMutableArray*) photos
{
    [main addToSecondary:photos];
}

- (void)addToAthletePhotos:(NSMutableArray*) photos
{
    [main addToSecondary:photos];
}

- (void)addToUserPhotos:(NSMutableArray*) photos
{
    [main setFilter:[NSString stringWithFormat:@"%@'s Photos", [account name]]];
    [main addToSecondary:photos];
}

- (void)createdPhoto:(NSString*) success
{
    
}

-(void)gotoProfile
{
    [profile moveIn];
}

-(void)gotoMain
{
    [main profileOut];
}

-(void)gotoSettings
{
    [settings moveIn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
