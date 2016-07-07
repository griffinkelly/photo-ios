//
//  LoginViewController.m
//  trac
//
//  Created by Nick Schulze on 4/22/16.
//  Copyright © 2016 Nick Schulze. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

-(id)init
{
    if(self)
    {
        UIScreen* main = [UIScreen mainScreen];
        width = main.bounds.size.width;
        height = main.bounds.size.height;
        
        self.view.frame = CGRectMake(0, 0, width, height);
        self.view.backgroundColor = [UIColor white];
        self.view.clipsToBounds = YES;
        
        image = [[UIImageView alloc] initWithFrame:CGRectMake(20, 70, width-40, (width-40)/5.89)];
        image.backgroundColor = [UIColor white];
        image.layer.cornerRadius = 8;
        [image setImage:[UIImage imageNamed:@"flashbanner.png"]];
        [self.view addSubview:image];
        
        email = [[TextField alloc] initMainTextField:@"username" atY:212];
        email.autocorrectionType = UITextAutocorrectionTypeNo;
        email.autocapitalizationType = UITextAutocapitalizationTypeNone;
        [self.view addSubview:email];
        
        password = [[TextField alloc] initMainTextField:@"password" atY:266];
        password.secureTextEntry = YES;
        [self.view addSubview:password];
        
        loginButton = [[Button alloc] initMainButton:@"Login" atY:320];
        [loginButton halfButtonAtX:(width/2)+5];
        [loginButton addTarget:self action:@selector(tracLogin) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:loginButton];
        
        registerButton = [[Button alloc] initSecondaryButton:@"Register" atY:320];
        [registerButton halfButtonAtX:10];
        [registerButton addTarget:self action:@selector(moveInRegister) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:registerButton];
        
        //        [email becomeFirstResponder];
        
        registerView = [[UIView alloc] initWithFrame:CGRectMake(0, height, width, height)];
        registerView.backgroundColor = [UIColor secondary];
        [self.view addSubview:registerView];
        
        registerScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        registerScroll.backgroundColor = [UIColor clearColor];
        registerScroll.contentSize = CGSizeMake(0, height+400);
        [registerScroll setShowsVerticalScrollIndicator:NO];
        [registerView addSubview:registerScroll];
        
        Button* close = [[Button alloc] initHeaderTextButton:@"Close" atX:width-80 atY:20];
        [close addTarget:self action:@selector(moveOutRegister) forControlEvents:UIControlEventTouchUpInside];
        [close setTitleColor:[UIColor white] forState:UIControlStateNormal];
        [registerView addSubview:close];
        
        Label* title = [[Label alloc] initMainLabel:@"Register for FlashFrame" atY:150];
        [title setTextColor:[UIColor white]];
        [registerScroll addSubview:title];
        
        registerImage = [[UIImageView alloc] initWithFrame:CGRectMake((width/2)-50, 30, 100, 100)];
        registerImage.backgroundColor = [UIColor white];
        registerImage.layer.cornerRadius = 8;
        registerImage.layer.masksToBounds = YES;
        [registerImage setImage:[UIImage imageNamed:@"flashicon.png"]];
        [registerScroll addSubview:registerImage];
        
        registerName = [[TextField alloc] initMainTextField:@"name" atY:236];
        registerName.autocorrectionType = UITextAutocorrectionTypeNo;
        registerName.autocapitalizationType = UITextAutocapitalizationTypeNone;
        [registerScroll addSubview:registerName];
        
        registerEmail = [[TextField alloc] initMainTextField:@"email" atY:290];
        registerEmail.autocorrectionType = UITextAutocorrectionTypeNo;
        registerEmail.autocapitalizationType = UITextAutocapitalizationTypeNone;
        [registerScroll addSubview:registerEmail];
        
        registerPassword = [[TextField alloc] initMainTextField:@"password" atY:344];
        registerPassword.secureTextEntry = YES;
        [registerScroll addSubview:registerPassword];
        
        registerSubmitButton = [[Button alloc] initRegisterButton:@"Register" atY:398];
        [registerSubmitButton addTarget:self action:@selector(tracRegister) forControlEvents:UIControlEventTouchUpInside];
        [registerScroll addSubview:registerSubmitButton];
    }
    return self;
}

-(void)tracLogin
{
    [trac racesForPage:0];
    [trac tracLogin:[email text] password:[password text]];
}

-(void)tracRegister
{
    [trac racesForPage:0];
    [trac tracRegister:[registerName text] email:[registerEmail text] password:[registerPassword text]];
}

-(void)invalidLogin
{
    email.backgroundColor = [UIColor lightRed];
    password.backgroundColor = [UIColor lightRed];
}

-(void)moveIn
{
    [UIView animateWithDuration:.4
                     animations:^{
                         self.view.center = CGPointMake(width/2, height/2);
                         
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
                         self.view.center = CGPointMake(width/2, -height);
                         
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:.25 animations:^{
                             self.view.center = CGPointMake((width/2), -height);
                         }];
                     }];
    [email resignFirstResponder];
    [password resignFirstResponder];
}

-(void)moveOutRegister
{
    [UIView animateWithDuration:.4
                     animations:^{
                         registerView.center = CGPointMake(width/2, 3*height/2);
                     }];
    [email becomeFirstResponder];
}

-(void)moveInRegister
{
    [UIView animateWithDuration:.4
                     animations:^{
                         registerView.center = CGPointMake(width/2, height/2);
                         
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:.25 animations:^{
                             registerView.center = CGPointMake((width/2), height/2);
                         }];
                     }];
    [registerName becomeFirstResponder];
}

-(void)injectTrac:(Trac*)_trac
{
    trac = _trac;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [email becomeFirstResponder];
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
