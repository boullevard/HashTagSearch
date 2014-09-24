//
//  UserDefaultsManager.h
//  HashTagSearchApp
//
//  Created by Nabil Mouzannar on 3/29/14.
//  Copyright (c) 2014 Nabil Mouzannar. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *SavedSearchTermsKey = @"SavedSearchTerms";

@interface UserDefaultsManager : NSObject

+ (void)saveSearchTerm:(NSString *)searchTerm;

+ (NSMutableArray *)searchTerms;

@end
