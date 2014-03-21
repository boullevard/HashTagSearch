//
//  TweetsController.h
//  HashTagSearchApp
//
//  Created by Nabil Mouzannar on 3/21/14.
//  Copyright (c) 2014 Nabil Mouzannar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TweetsController : NSObject

- (void)fetchTweetsWithCompletionBlock:(void (^)(BOOL success))completionBlock;


@end
