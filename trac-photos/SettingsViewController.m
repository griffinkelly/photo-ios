//
//  SettingsViewController.m
//  trac
//
//  Created by Nick Schulze on 4/22/16.
//  Copyright © 2016 Nick Schulze. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        UIScreen* main = [UIScreen mainScreen];
        width = main.bounds.size.width;
        height = main.bounds.size.height;
        
        self.view.frame = CGRectMake(0, height, width, height);
        self.view.backgroundColor = [UIColor lightGray];
        
        scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 74, width, height-74)];
        scroll.backgroundColor = [UIColor clearColor];
        [scroll setContentSize:CGSizeMake(width, height*2)];
        scroll.clipsToBounds = YES;
        scroll.layer.masksToBounds = YES;
        [scroll setShowsVerticalScrollIndicator:NO];
        [self.view addSubview:scroll];
        
        UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 64)];
        header.backgroundColor = [UIColor blue];
        header.layer.shadowColor = [UIColor darkGrayColor].CGColor;
        header.layer.shadowOpacity = .2;
        header.layer.shadowOffset = CGSizeMake(3, 2);
        header.layer.masksToBounds = NO;
        header.clipsToBounds = NO;
        [self.view addSubview:header];
        
        UIView* hline = [[UIView alloc] initWithFrame:CGRectMake(0, 62, width, 2)];
        hline.backgroundColor = [UIColor lightBlue];
        [header addSubview:hline];
        
        Label* title = [[Label alloc] initMainLabel:@"Settings" atY:18];
        [title setTextColor:[UIColor white]];
        [self.view addSubview:title];
        
        Button* close = [[Button alloc] initHeaderTextButton:@"Close" atX:width-90 atY:20];
        [close addTarget:self action:@selector(moveOut) forControlEvents:UIControlEventTouchUpInside];
        [close setTitleColor:[UIColor white] forState:UIControlStateNormal];
        [self.view addSubview:close];
        
        name = [[TextField alloc] initMainTextField:@"name" atY:72];
        name.backgroundColor = [UIColor clearColor];
        name.layer.borderColor = [UIColor clearColor].CGColor;
        [self.view addSubview:name];
        
        UIView* line = [[UIView alloc] initWithFrame:CGRectMake(20, 122, width-40, 1)];
        line.backgroundColor = [UIColor gray];
        [self.view addSubview:line];
        
        email = [[TextField alloc] initMainTextField:@"email" atY:132];
        email.backgroundColor = [UIColor clearColor];
        email.layer.borderColor = [UIColor clearColor].CGColor;
        [self.view addSubview:email];
        
        UIView* line2 = [[UIView alloc] initWithFrame:CGRectMake(20, 182, width-40, 1)];
        line2.backgroundColor = [UIColor gray];
        [self.view addSubview:line2];
        
        password = [[TextField alloc] initMainTextField:@"password" atY:192];
        password.backgroundColor = [UIColor clearColor];
        password.layer.borderColor = [UIColor clearColor].CGColor;
//        [self.view addSubview:password];
        
        UIView* line3 = [[UIView alloc] initWithFrame:CGRectMake(20, 242, width-40, 1)];
        line3.backgroundColor = [UIColor gray];
//        [self.view addSubview:line3];
        
        trainer = [[TextField alloc] initMainTextField:@"bib number" atY:252];
        trainer.backgroundColor = [UIColor clearColor];
        trainer.layer.borderColor = [UIColor clearColor].CGColor;
        [trainer setText:@"bib number: 158"];
//        [self.view addSubview:trainer];
        
        UIView* line4 = [[UIView alloc] initWithFrame:CGRectMake(20, 302, width-40, 1)];
        line4.backgroundColor = [UIColor gray];
//        [self.view addSubview:line4];
        
        notifications = [[Button alloc] initRowTextButton:@"Notifications" atY:312];
//        [self.view addSubview:notifications];
        
        UIView* line5 = [[UIView alloc] initWithFrame:CGRectMake(20, 362, width-40, 1)];
        line5.backgroundColor = [UIColor gray];
//        [self.view addSubview:line5];
        
        feedback = [[Button alloc] initRowTextButton:@"Feedback" atY:372];
        [self.view addSubview:feedback];
        
        UIView* line6 = [[UIView alloc] initWithFrame:CGRectMake(20, 422, width-40, 1)];
        line6.backgroundColor = [UIColor gray];
        [self.view addSubview:line6];
        
        logout = [[Button alloc] initRowTextButton:@"Logout" atY:432];
        [logout addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:logout];
        
        UIView* line7 = [[UIView alloc] initWithFrame:CGRectMake(20, 482, width-40, 1)];
        line7.backgroundColor = [UIColor gray];
        [self.view addSubview:line7];
    }
    return self;
}


-(void)setTracAccount:(TracAccount*)tracAccount
{
    [email setText:[NSString stringWithFormat:@"username: %@",[tracAccount email]]];
    [name setText:[NSString stringWithFormat:@"name: %@",[tracAccount name]]];
}

-(void)moveIn
{
    [UIView animateWithDuration:.4
                     animations:^{
                         self.view.center = CGPointMake(width/2, height/2-5);
                         
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:.25 animations:^{
                             self.view.center = CGPointMake((width/2), height/2);
                         }];
                     }];
}

-(void)moveOut
{
    [UIView animateWithDuration:.4
                     animations:^{
                         self.view.center = CGPointMake(width/2, 3*height/2);
                     }];
}

-(void)injectTrac:(Trac*)_trac
{
    trac = _trac;
}

-(void)logout
{
    [self moveOut];
    [trac logout];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
