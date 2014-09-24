//
//  UserDefaultsManager.m
//  HashTagSearchApp
//
//  Created by Nabil Mouzannar on 3/29/14.
//  Copyright (c) 2014 Nabil Mouzannar. All rights reserved.
//

#import "UserDefaultsManager.h"

@implementation UserDefaultsManager

+ (void)saveSearchTerm:(NSString *)searchTerm
{
    if (searchTerm == nil)
    {
        return;
    }
    
    NSMutableArray *searchTerms = [self searchTerms]; //why couldnt i init this in viewDidLoad
    if (searchTerms)
    {
        [searchTerms addObject:searchTerm];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (NSMutableArray *)searchTerms
{
    NSArray *savedResults = [[NSUserDefaults standardUserDefaults] objectForKey:SavedSearchTermsKey];
    
    return [savedResults mutableCopy];
}

@end
