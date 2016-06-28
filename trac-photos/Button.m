//
//  Button.m
//  trac
//
//  Created by Nick Schulze on 4/22/16.
//  Copyright © 2016 Nick Schulze. All rights reserved.
//

#import "Button.h"

@implementation Button

-(id)initMainButton:(NSString*)title atY:(CGFloat)y
{
    UIScreen* main = [UIScreen mainScreen];
    float width = main.bounds.size.width;
    
    self = [super initWithFrame:CGRectMake(10, y, width-20, 64)];
    if (self)
    {
        [self setBackgroundColor:[UIColor main]];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:[UIColor white] forState:UIControlStateNormal];
        self.layer.cornerRadius = 5;
    }
    return self;
}

-(id)initRegisterButton:(NSString*)title atY:(CGFloat)y
{
    UIScreen* main = [UIScreen mainScreen];
    float width = main.bounds.size.width;
    
    self = [super initWithFrame:CGRectMake(20, y, width-40, 44)];
    if (self)
    {
        [self setBackgroundColor:[UIColor main]];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:[UIColor white] forState:UIControlStateNormal];
        self.layer.cornerRadius = 5;
    }
    return self;
}

-(id)initSecondaryButton:(NSString*)title atY:(CGFloat)y
{
    UIScreen* main = [UIScreen mainScreen];
    float width = main.bounds.size.width;
    
    self = [super initWithFrame:CGRectMake(10, y, width-20, 64)];
    if (self)
    {
        [self setBackgroundColor:[UIColor secondary]];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blue] forState:UIControlStateNormal];
        self.layer.cornerRadius = 5;
    }
    return self;
}


-(id)initTertiaryButton:(NSString*)title atY:(CGFloat)y
{
    UIScreen* main = [UIScreen mainScreen];
    float width = main.bounds.size.width;
    
    self = [super initWithFrame:CGRectMake(10, y, width-20, 64)];
    if (self)
    {
        [self setBackgroundColor:[UIColor tertiary]];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:[UIColor white] forState:UIControlStateNormal];
        self.layer.cornerRadius = 5;
    }
    return self;
}

-(id)initActivityDashboardButton:(NSString*)title atY:(CGFloat)y
{
    UIScreen* main = [UIScreen mainScreen];
    float width = main.bounds.size.width;
    
    self = [super initWithFrame:CGRectMake(10, y, width-20, 120)];
    if (self)
    {
        self.backgroundColor = [UIColor white];
        self.layer.cornerRadius = 5;
        self.layer.borderColor = [UIColor gray].CGColor;
        self.layer.borderWidth = 1;
        self.layer.shadowColor = [UIColor darkGrayColor].CGColor;
        //        self.layer.shadowOpacity = .5;
        //        self.layer.shadowOffset = CGSizeMake(1, 1);
        self.layer.masksToBounds = NO;
        
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, width-40, 32)];
        [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16.0]];
        [label setText:title];
        [self addSubview:label];
        
        description = [[UITextView alloc] initWithFrame:CGRectMake(10, 32, width-40, 52)];
        [description setFont:[UIFont fontWithName:@"Helvetica" size:14.0]];
        [description setText:@"this is the description"];
        [description setUserInteractionEnabled:NO];
        [description setBackgroundColor:[UIColor clearColor]];
        [self addSubview:description];
        
        UILabel* date = [[UILabel alloc] initWithFrame:CGRectMake(15, 90, width-50, 32)];
        [date setFont:[UIFont fontWithName:@"Helvetica" size:12.0]];
        [date setText:@"Last Taken: May 5, 2016 at 9:34 AM"];
        [date setTextAlignment:NSTextAlignmentRight];
        [date setTextColor:[UIColor lightGrayColor]];
        [self addSubview:date];
        
        UIImageView* rightArrow = [[UIImageView alloc] initWithFrame:CGRectMake(width-20-24, 20, 11, 18)];
        [rightArrow setImage:[UIImage imageNamed:@"right.png"]];
        [self addSubview:rightArrow];
    }
    return self;
}

-(id)initHeaderTextButton:(NSString*)title atX:(CGFloat)x atY:(CGFloat)y
{
    UIScreen* main = [UIScreen mainScreen];
    
    self = [super initWithFrame:CGRectMake(x, y, 64, 44)];
    if (self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:[UIColor main] forState:UIControlStateNormal];
        self.layer.cornerRadius = 5;
    }
    return self;
}


-(id)initRowTextButton:(NSString*)title atY:(CGFloat)y
{
    UIScreen* main = [UIScreen mainScreen];
    float width = main.bounds.size.width;
    
    self = [super initWithFrame:CGRectMake(20, y, width-40, 44)];
    if (self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:[UIColor main] forState:UIControlStateNormal];
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.layer.cornerRadius = 5;
    }
    return self;
}

-(void)halfButtonAtX:(CGFloat)x
{
    UIScreen* main = [UIScreen mainScreen];
    float width = main.bounds.size.width;
    
    self.frame = CGRectMake(x, self.center.y-22, ((width-20)/2)-5, 44);
}

-(void)halfButtonAtX:(CGFloat)x forWidth:(CGFloat)width
{
    self.frame = CGRectMake(x, self.center.y-22, ((width-20)/2)-5, 44);
}

-(void)setDescription:(NSString*)_description
{
    [description setText:_description];
}

-(void)setCenter:(CGPoint)center
{
    self.center = center;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
