//
//  TweetsViewController.m
//  HashTagSearchApp
//
//  Created by Nabil Mouzannar on 3/21/14.
//  Copyright (c) 2014 Nabil Mouzannar. All rights reserved.
//

#import "TweetsViewController.h"
#import "TweetsController.h"
#import "STTwitter.h"

@interface TweetsViewController ()

@property (nonatomic, strong) IBOutlet UITableView *tableView; //link this file to the table view
@property (strong, nonatomic) NSMutableArray *twitterFeed;
@property(nonatomic,strong) TweetsController *tweetsController;
@property (nonatomic, strong) STTwitterAPI *twitter;

@end

@implementation TweetsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.title = [NSString stringWithFormat:@"HashTag search for %@", self.searchTerm];
    self.searchTermTextField.text = self.searchTerm;
    
    self.tweetsController = [[TweetsController alloc] init];
    [self updateContent];
}

- (void)updateContent
{
    STTwitterAPI *twitter = [STTwitterAPI twitterAPIAppOnlyWithConsumerKey:@"hwrttolDROMvECG0JOYnuw"
                                                            consumerSecret:@"5tcvsIFYEGsurmL2sKDcp7RAcOROI8YJLTVlpudezk"];
    NSString *errorCode;
    NSString *myResults;
    [twitter verifyCredentialsWithSuccessBlock:^(NSString *bearerToken) {
        
    [twitter _getSearchTypeaheadQuery:@"sxsw14" resultType:myResults sendErrorCodes:errorCode
   
   
                                  successBlock:^(NSArray *statuses) {
                                      
                                                self.twitterFeed = [NSMutableArray arrayWithArray:statuses];
                                    
                                                [self.tableView reloadData];
                                      
                                  } errorBlock:^(NSError *error) {
                                      
                                      NSLog(@"%@", error.debugDescription);
                                      
                                  }];
        
    } errorBlock:^(NSError *error) {
        
        NSLog(@"%@", error.debugDescription);
        
    }];
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
    
    cell.textLabel.text = self.twitterFeed[indexPath.row][@"text"];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.twitterFeed count];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
