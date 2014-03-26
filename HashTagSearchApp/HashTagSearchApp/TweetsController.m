//
//  TweetsController.m
//  HashTagSearchApp
//
//  Created by Nabil Mouzannar on 3/21/14.
//  Copyright (c) 2014 Nabil Mouzannar. All rights reserved.
//

#import "TweetsController.h"


@implementation TweetsController

-
(id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (void)fetchTweetsWithCompletionBlock:(void (^)(BOOL success))completionBlock
{
    NSString *twitterEndpoint = @"https://api.twitter.com/1.1/search/tweets.json?q=%23sxsw14&count=10";
    
    
    NSURL *URL = [NSURL URLWithString:twitterEndpoint];
    NSLog(@"fetchTweetsWithCompletionBlock");
    // 1. Get a reference to the shared NSURLSession
    NSURLSession *session = [NSURLSession sharedSession];
    // 2. Invoke the dataTaskWithURL:completionHandler: method on the shared NSURLSession
    NSURLSessionDataTask *task = [session dataTaskWithURL:URL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        // 3. In the completionHandler, check that the response has status code 200. If yes, call completionBlock(YES). If no, call completionBlock(NO).
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode == 200)
        {
            NSLog(@"Status code is 200");
            completionBlock (YES);
        }
        else{
            NSLog(@"Status code is %@ ",httpResponse.allHeaderFields);
            completionBlock (NO);
        }
    }];
    
    [task resume];
    
}


@end
