//
//  ViewController.m
//  Workshop
//
//  Copyright (c) 2015 box. All rights reserved.
//

#import "ViewController.h"
#import "BoxContentSDK.h"
#import "FolderViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [BOXContentClient setClientID:@"acn342p9n050408fr0x49mbtyc0heodk" clientSecret:@"pcYiv5dnhyPWqUWgNkfXPGF1x9OcIRpn"];

    // STEP_ONE
    
//    BOXContentClient *contentClient = [BOXContentClient defaultClient];
//    [contentClient authenticateWithCompletionBlock:^(BOXUser *user, NSError *error) {
//        if (error == nil) {
//            [self displayFolderViewController];
//        }
//    }];
}

- (void)displayFolderViewController
{
    FolderViewController *folderController = [[FolderViewController alloc] initWithFolderID:BOXAPIFolderIDRoot];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:folderController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

@end
