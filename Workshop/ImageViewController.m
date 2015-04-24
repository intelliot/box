//
//  ImageViewController.m
//  Workshop
//
//  Copyright (c) 2015 box. All rights reserved.
//

#import "ImageViewController.h"
#import <BoxShareSDK/BoxShareSDK.h>

@interface ImageViewController ()

@property (nonatomic, readwrite, strong) NSString *fileID;
@property (nonatomic, readwrite, strong) UIImageView *imageView;

@end

@implementation ImageViewController

- (instancetype)initWithFileID:(NSString *)fileID
{
    if (self = [super init]) {
        _fileID = fileID;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UIBarButtonItem *share = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share)];
    self.navigationItem.rightBarButtonItem = share;
    
    self.imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.imageView];
    
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:self.fileID];
    
    // STEP_THREE

    BOXFileDownloadRequest *request = [[BOXContentClient defaultClient] fileDownloadRequestWithID:self.fileID toLocalFilePath:path];
    [request performRequestWithProgress:^(long long totalBytesTransferred, long long totalBytesExpectedToTransfer) {
        //
    } completion:^(NSError *error) {
        if (error == nil) {
            self.imageView.image = [self imageFromPath:path];
        }
    }];
}

- (void)share
{
    // STEP_FOUR
    
    BOXSharedLinkViewController *viewController = [[BOXSharedLinkViewController alloc] initWithContentClient:[BOXContentClient defaultClient] fileID:self.fileID];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (UIImage *)imageFromPath:(NSString *)path
{
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:path];
    UIImage *image = [UIImage imageWithData:data];
    
    return image;
}

@end
