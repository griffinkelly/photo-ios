//
//  TracRaceButton.m
//  trac-photos
//
//  Created by Nick Schulze on 6/12/16.
//  Copyright © 2016 TRAC. All rights reserved.
//

#import "TracRaceButton.h"

@implementation TracRaceButton

@synthesize delegate;

-(id)initWithTracRace:(TracRace*)_race
{
    race = _race;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Light" size:12]};
    CGSize buttonSize = [[race name] sizeWithAttributes:attributes];
    
    self = [super initWithFrame:CGRectMake(10, 5, buttonSize.width+20, 34)];
    buttonWidth = buttonSize.width+20;
    
    if (self)
    {
        [self setBackgroundColor:[UIColor white]];
        self.layer.cornerRadius = 17;
        
        name = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, buttonWidth-20, 34)];
        name.backgroundColor = [UIColor clearColor];
        [name setText:[race name]];
        [name setUserInteractionEnabled:NO];
        [name setFont:[UIFont fontWithName:@"Helvetica-Light" size:12.0]];
        [name setTextColor:[UIColor blue]];
        [name setTextAlignment:NSTextAlignmentRight];
        [self addSubview:name];
        
        tap = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, 34)];
        [tap addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tap];
    }
    return self;
}

-(id)initWithTracRaceForCreate:(TracRace*)_race
{
    race = _race;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Light" size:16]};
    CGSize buttonSize = [[race name] sizeWithAttributes:attributes];
    
    self = [super initWithFrame:CGRectMake(10, 5, buttonSize.width+20, 34)];
    buttonWidth = buttonSize.width+20;
    
    if (self)
    {
        [self setBackgroundColor:[UIColor white]];
        self.layer.cornerRadius = 17;
        
        name = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, buttonWidth-20, 34)];
        name.backgroundColor = [UIColor clearColor];
        [name setText:[race name]];
        [name setUserInteractionEnabled:NO];
        [name setFont:[UIFont fontWithName:@"Helvetica-Light" size:16.0]];
        [name setTextColor:[UIColor blue]];
        [name setTextAlignment:NSTextAlignmentRight];
        [self addSubview:name];
        
        tap = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, 34)];
        [tap addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tap];
    }
    return self;
}

-(void)tap
{
//    [trac photosForRace:[[race identifier] intValue] atPage:0];
    [[self delegate] setRace:race];
}

-(CGFloat)buttonWidth
{
    return buttonWidth;
}

-(void)shift:(CGFloat)buttonCursor
{
    self.center = CGPointMake(buttonCursor+(buttonWidth/2), 20);
}


-(void)shiftDown:(int)i
{
    self.center = CGPointMake((220/2), 17+(39*i));
}

@end
