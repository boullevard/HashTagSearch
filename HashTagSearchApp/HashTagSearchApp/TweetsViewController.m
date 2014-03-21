//
//  TweetsViewController.m
//  HashTagSearchApp
//
//  Created by Nabil Mouzannar on 3/21/14.
//  Copyright (c) 2014 Nabil Mouzannar. All rights reserved.
//

#import "TweetsViewController.h"
#import "TweetsController.h"

@interface TweetsViewController ()

@property(nonatomic,strong) TweetsController *tweetsController;

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
    [self.tweetsController fetchPopularMediaWithCompletionBlock:^(BOOL success) {
        //   how are we getting : self.mediaObjects ? we re not! we know that we have it and is successful in mediaController
        
        //dispatch the logic in this block to the main queue ie: thread (called Grand Central Dispatch)
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            if (success)
            {
                // Reload the tableview here
                NSLog(@"Success");
            }
            else
            {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Uh Oh!"
                                                                 message:@"An error occurred"
                                                                delegate:nil
                                                       cancelButtonTitle:@"Okay"
                                                       otherButtonTitles:nil]; //question how i can get the api error message
                [alert show];
            }
        });
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
