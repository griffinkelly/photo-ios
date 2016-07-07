//
//  UIColor+trac.m
//  trac
//
//  Created by Nick Schulze on 4/22/16.
//  Copyright © 2016 Nick Schulze. All rights reserved.
//

#import "UIColor+trac.h"

@implementation UIColor (trac)

+(UIColor*)main
{
    return [self orange];
}

+(UIColor*)secondary
{
    return [self lightBlue];
}

+(UIColor*)tertiary
{
    return [self black];
}

+(UIColor*)white
{
    return [UIColor colorWithRed:251.0/255.0 green:251.0/255.0 blue:251.0/255.0 alpha:1.0];
}

//#F26522
+(UIColor*)orange
{
    return [UIColor colorWithRed:242.0/255.0 green:101.0/255.0 blue:34.0/255.0 alpha:1.0];
}
//#f8b290 248,178,144
+(UIColor*)lightOrange
{
    return [UIColor colorWithRed:248.0/255.0 green:178.0/255.0 blue:144.0/255.0 alpha:1.0];
}
//#FFEB3B
+(UIColor*)yellow
{
    return [UIColor colorWithRed:255.0/255.0 green:207.0/255.0 blue:25.0/255.0 alpha:1.0];
}

//#fffbd5
+(UIColor*)lightYellow
{
    return [UIColor colorWithRed:255.0/255.0 green:249.0/255.0 blue:188.0/255.0 alpha:1.0];
}

//#2D3940
+(UIColor*)black
{
    return [UIColor colorWithRed:45.0/255.0 green:57.0/255.0 blue:64.0/255.0 alpha:1.0];
}

+(UIColor*)red
{
    return [UIColor colorWithRed:255.0/255.0 green:59.0/255.0 blue:79.0/255.0 alpha:1.0];
}

//2A6297
+(UIColor*)blue
{
    return [UIColor colorWithRed:42.0/255.0 green:98.0/255.0 blue:151.0/255.0 alpha:1.0];
}

//bbd5ec
+(UIColor*)lightBlue
{
    return [UIColor colorWithRed:187.0/255.0 green:213.0/255.0 blue:236.0/255.0 alpha:1.0];
}

//6f20e4
+(UIColor*)lightPurple
{
    return [UIColor colorWithRed:111.0/255.0 green:32.0/255.0 blue:228.0/255.0 alpha:1.0];
}

+(UIColor*)lightRed
{
    return [UIColor colorWithRed:255.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0];
}

+(UIColor*)gray
{
    return [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1.0];
}

+(UIColor*)lightGray
{
    return [UIColor colorWithRed:236.0/255.0 green:236.0/255.0 blue:236.0/255.0 alpha:1.0];
}

@end
