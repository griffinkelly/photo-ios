//
//  TextField.m
//  trac
//
//  Created by Nick Schulze on 4/22/16.
//  Copyright © 2016 Nick Schulze. All rights reserved.
//

#import "TextField.h"

@implementation TextField

-(id)initMainTextField:(NSString*)placeholder atY:(CGFloat)y
{
    UIScreen* main = [UIScreen mainScreen];
    float width = main.bounds.size.width;
    
    self = [super initWithFrame:CGRectMake(20, y, width-40, 44)];
    if (self)
    {
        
        self.layer.cornerRadius = 8;
        self.layer.borderColor = [UIColor gray].CGColor;
        self.layer.borderWidth = 1;
        self.placeholder = placeholder;
        self.backgroundColor = [UIColor white];
        self.textColor = [UIColor black];
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
        self.leftView = paddingView;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
