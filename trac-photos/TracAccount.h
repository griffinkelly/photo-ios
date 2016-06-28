//
//  TracAccount.h
//  trac-photos
//
//  Created by Nick Schulze on 6/12/16.
//  Copyright © 2016 TRAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TracAccount : NSObject

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* email;
@property (nonatomic, retain) NSString* token;

@end
