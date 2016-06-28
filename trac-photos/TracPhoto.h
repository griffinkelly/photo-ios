//
//  TracPhoto.h
//  trac-photos
//
//  Created by Nick Schulze on 6/12/16.
//  Copyright © 2016 TRAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TracPhoto : NSObject

@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* description;
@property (nonatomic, retain) NSString* created_at;
@property (nonatomic, retain) NSString* url;
@property (nonatomic, retain) NSString* scaled_url;

@end
