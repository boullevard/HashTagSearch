//
//  SearchViewController.m
//  HashTagSearchApp
//
//  Created by Nabil Mouzannar on 3/19/14.
//  Copyright (c) 2014 Nabil Mouzannar. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController () <UISearchBarDelegate>

@property (nonatomic, strong) NSString *userInputSearchText;
@property (nonatomic, strong) NSString *userSavedInputSearchText;

@end

@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
          NSLog(@"retrieveSearchTextFromNSUSerDefaults %@",self.retrieveSearchTextFromNSUSerDefaults);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"when did the view Load ?");

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{ // called when keyboard search button pressed
    self.userInputSearchText = searchBar.text;
    [self saveSearchTextToNSUSerDefaults: self.userInputSearchText];
}

- (void) saveSearchTextToNSUSerDefaults:(NSString *) searchText{
    NSUserDefaults *searches = [NSUserDefaults standardUserDefaults]; //why couldnt i init this in viewDidLoad
    [searches setObject:searchText forKey:@"searchText"];
    [searches synchronize];
    NSLog(@"saveSearchTextToNSUSerDefaults userInputSearchText: %@.",searchText);
}

- (NSString *) retrieveSearchTextFromNSUSerDefaults {
    NSUserDefaults *searches = [NSUserDefaults standardUserDefaults];
    self.userSavedInputSearchText = [searches stringForKey:@"searchText"];
    return self.userSavedInputSearchText;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
