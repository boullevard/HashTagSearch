//
//  SearchViewController.m
//  HashTagSearchApp
//
//  Created by Nabil Mouzannar on 3/19/14.
//  Copyright (c) 2014 Nabil Mouzannar. All rights reserved.
//
// quesiton: how can i have the cell in tableview editable ie: able to DELETE them


#import "SearchViewController.h"
#import "TweetsViewController.h"

@interface SearchViewController () <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSString *userInputSearchText;
@property (nonatomic, strong) NSMutableArray *searchTextArray ;
@property (nonatomic, weak) IBOutlet UITableView *tableView; //link this file to the table view
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar; //link this file to the SearchBar view
@end

@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //initialize a NSMutable array to hold the last 10 searches
        self.searchTextArray = [[NSMutableArray alloc] initWithCapacity:10];
  
        NSMutableArray *savedResults = [self retrieveSearchTextFromNSUSerDefaults];
        if (savedResults)
        {
            self.searchTextArray = savedResults;
        }

        //populate table view with saved searches in NSUserDefaults if it is not empty
//        if ([self retrieveSearchTextFromNSUSerDefaults] != NULL)
//        {
//            self.searchTextArray = [self retrieveSearchTextFromNSUSerDefaults];
//        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - Actions

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    // called when keyboard search button pressed
    self.userInputSearchText = searchBar.text;
    
    //Call to saveSearchText to the saveSearchTExtArray
    [self saveSearchTextToArray: self.userInputSearchText];
    [searchBar resignFirstResponder];//dismisses keyboard
}

- (void) saveSearchTextToArray:(NSString *) searchText
{
    //add searchTExt to searchTextArray
    [self.searchTextArray addObject:searchText];
    //and then store it in nsuserdefaults
    
    //update tableview
    [self.tableView reloadData];
    
    //Save user searches to NSUserDefaults
    [self saveSearchTextToNSUSerDefaults: self.searchTextArray];
}

#pragma mark - UserDefaults

- (void) saveSearchTextToNSUSerDefaults:(NSArray *) searchTextArray //Save array to NsUserDefaults
{
    NSUserDefaults *searches = [NSUserDefaults standardUserDefaults]; //why couldnt i init this in viewDidLoad
    [searches setObject:searchTextArray forKey:@"searchTextArray"];
    [searches synchronize];
}

//Retrieve Search Array
- (NSMutableArray *)retrieveSearchTextFromNSUSerDefaults
{
    NSUserDefaults *searches = [NSUserDefaults standardUserDefaults];
    NSArray *savedResults = [searches objectForKey:@"searchTextArray"];
    
    return [savedResults mutableCopy];
}

//required functions (2) for UITableViewDataSource
#pragma mark - UITableView Datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    cell.textLabel.text = self.searchTextArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.searchTextArray count]; //return size of the array
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TweetsViewController *viewController = [[TweetsViewController alloc] initWithNibName:@"TweetsViewController" bundle:Nil];
    viewController.searchTerm = [self.searchTextArray objectAtIndex:indexPath.row];
    viewController.view.backgroundColor = [UIColor grayColor];
    [self.navigationController pushViewController:viewController animated:YES];
    //question how did we get self.navigationController
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
