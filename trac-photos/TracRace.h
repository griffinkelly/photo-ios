//
//  TracRace.h
//  trac-photos
//
//  Created by Nick Schulze on 6/12/16.
//  Copyright © 2016 TRAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TracRace : NSObject

@property (nonatomic, retain) NSString* identifier;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* city;
@property (nonatomic, retain) NSString* state;
@property (nonatomic, retain) NSString* country;
@property (nonatomic, retain) NSString* latitude;
@property (nonatomic, retain) NSString* longitude;

@end
