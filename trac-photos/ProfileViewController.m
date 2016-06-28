//
//  ProfileViewController.m
//  trac
//
//  Created by Nick Schulze on 5/7/16.
//  Copyright © 2016 Nick Schulze. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self)
    {
        UIScreen* main = [UIScreen mainScreen];
        width = main.bounds.size.width;
        height = main.bounds.size.height;
        
        self.view.frame = CGRectMake(-width, 0, width-60, height);
        self.view.backgroundColor = [UIColor white];
        
        UIView* upper = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width-60, 200)];
        upper.backgroundColor = [UIColor gray];
        [self.view addSubview:upper];
        
        Button* close = [[Button alloc] initHeaderTextButton:@"Close" atX:width-130 atY:5];
        [close addTarget:self action:@selector(moveOut) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:close];
        
        UIView* logo_background = [[UIImageView alloc] initWithFrame:CGRectMake((width-60)/2-50, 20, 100, 100)];
        [logo_background setBackgroundColor:[UIColor lightBlue]];
        logo_background.layer.cornerRadius = 50;
        logo_background.layer.borderColor = [UIColor white].CGColor;
        logo_background.layer.borderWidth = 3;
        [self.view addSubview:logo_background];
        
        UIImageView* logo = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
        [logo setBackgroundColor:[UIColor clearColor]];
        [logo setImage:[UIImage imageNamed:@"profile.png"]];
        [logo_background addSubview:logo];
        
        name = [[UILabel alloc] initWithFrame:CGRectMake(10, 130, width-80, 32)];
        [name setText:@"Nick Schulze"];
        [name setTextAlignment:NSTextAlignmentCenter];
        [name setFont:[UIFont fontWithName:@"Helvetica" size:24.0]];
        [name setTextColor:[UIColor tertiary]];
        [self.view addSubview:name];
        
        email = [[UILabel alloc] initWithFrame:CGRectMake(10, 155, width-80, 32)];
        [email setText:@"nschulze16@gmail.com"];
        [email setTextAlignment:NSTextAlignmentCenter];
        [email setFont:[UIFont fontWithName:@"Helvetica-Light" size:18.0]];
        [email setTextColor:[UIColor tertiary]];
        [self.view addSubview:email];
        
        UIButton* settings = [[UIButton alloc] initWithFrame:CGRectMake(20, 200, width-100, 60)];
        settings.backgroundColor = [UIColor clearColor];
        settings.layer.cornerRadius = 30;
        [settings setTitle:@"Settings" forState:UIControlStateNormal];
        [settings addTarget:self action:@selector(settings) forControlEvents:UIControlEventTouchUpInside];
        settings.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [settings setTitleColor:[UIColor tertiary] forState:UIControlStateNormal];
        [self.view addSubview:settings];
        
        UIButton* myphotos = [[UIButton alloc] initWithFrame:CGRectMake(20, 260, width-100, 60)];
        myphotos.backgroundColor = [UIColor clearColor];
        myphotos.layer.cornerRadius = 30;
        myphotos.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [myphotos setTitle:@"My Photos" forState:UIControlStateNormal];
        [myphotos setTitleColor:[UIColor tertiary] forState:UIControlStateNormal];
        [myphotos addTarget:self action:@selector(myPhotos) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:myphotos];

        UIButton* savephotos = [[UIButton alloc] initWithFrame:CGRectMake(20, 320, width-100, 60)];
        savephotos.backgroundColor = [UIColor clearColor];
        savephotos.layer.cornerRadius = 30;
        savephotos.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [savephotos setTitle:@"Saved Photos" forState:UIControlStateNormal];
        [savephotos setTitleColor:[UIColor tertiary] forState:UIControlStateNormal];
//        [self.view addSubview:savephotos];
        
        CGFloat buttonH = (width-80)/5.89;
        UIImageView* banner = [[UIImageView alloc] initWithFrame:CGRectMake(10, height-28-buttonH, width-80, buttonH)];
        banner.backgroundColor = [UIColor white];
        [banner setImage:[UIImage imageNamed:@"tracbanner.png"]];
        banner.layer.cornerRadius = 5;
        [self.view addSubview:banner];
        
        UIButton* terms = [[UIButton alloc] initWithFrame:CGRectMake(10, height-24, (width-60)/2-10, 16)];
        terms.backgroundColor = [UIColor clearColor];
        [terms setTitle:@"Terms of Service" forState:UIControlStateNormal];
        terms.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [terms.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:14.0]];
        [terms setTitleColor:[UIColor tertiary] forState:UIControlStateNormal];
        [self.view addSubview:terms];
        
        UIButton* privacy = [[UIButton alloc] initWithFrame:CGRectMake((width-60)/2, height-24, (width-60)/2-10, 16)];
        privacy.backgroundColor = [UIColor clearColor];
        [privacy setTitle:@"Privacy Policy" forState:UIControlStateNormal];
        privacy.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [privacy.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:14.0]];
        [privacy setTitleColor:[UIColor tertiary] forState:UIControlStateNormal];
        [self.view addSubview:privacy];
    }
    return self;
}

-(void)myPhotos
{
    [trac userPhotosForPage:0];
}


-(void)setTracAccount:(TracAccount*)tracAccount
{
    [email setText:[tracAccount email]];
    [name setText:[tracAccount name]];
}

-(void)settings
{
    [[self delegate] gotoSettings];
}

-(void)moveIn
{
    [UIView animateWithDuration:.4
                     animations:^{
                         self.view.center = CGPointMake(width/2-30, height/2);
                     }];
}

-(void)moveOut
{
    [[self delegate] gotoMain];
    [UIView animateWithDuration:.4
                     animations:^{
                         self.view.center = CGPointMake(-width/2, height/2);
                     }];
}

-(void)injectTrac:(Trac*)_trac
{
    trac = _trac;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
