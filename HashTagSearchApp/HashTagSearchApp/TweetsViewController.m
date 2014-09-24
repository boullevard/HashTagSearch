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

@property (nonatomic, weak) IBOutlet UITableView *tableView; //link this file to the table view
@property (strong, nonatomic) NSMutableArray *twitterFeed;
@property (nonatomic, strong) TweetsController *tweetsController;

@property (nonatomic, strong) STTwitterAPI *twitter; // delete

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
    
    self.tweetsController = [[TweetsController alloc] init];
    [self updateContent];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark

- (void)updateContent
{
    [self.tweetsController fetchTweetsWithCompletionBlock:^(BOOL success) {
        
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
    
    cell.textLabel.text = @"hi";
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"count: %d", [self.twitterFeed count]);
    return [self.twitterFeed count];
}

@end
