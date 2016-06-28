//
//  Label.m
//  trac
//
//  Created by Nick Schulze on 5/3/16.
//  Copyright © 2016 Nick Schulze. All rights reserved.
//

#import "Label.h"

@implementation Label

-(id)initMainLabel:(NSString*)text atY:(CGFloat)y
{
    UIScreen* main = [UIScreen mainScreen];
    float width = main.bounds.size.width;
    
    self = [super initWithFrame:CGRectMake(10, y, width-20, 44)];
    if (self)
    {
        [self setText:text];
        [self setTextAlignment:NSTextAlignmentCenter];
        [self setFont:[UIFont fontWithName:@"Helvetica-Light" size:24.0]];
        [self setTextColor:[UIColor black]];
        
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
