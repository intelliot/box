//
//  FolderViewController.m
//  Workshop
//
//  Copyright (c) 2015 box. All rights reserved.
//

#import "FolderViewController.h"
#import "ImageViewController.h"

@interface FolderViewController ()

@property (nonatomic, readwrite, strong) NSString *folderID;
@property (nonatomic, readwrite, strong) NSArray *items;

@end

@implementation FolderViewController

- (instancetype)initWithFolderID:(NSString *)folderID
{
    if (self = [super init]) {
        _folderID = folderID;
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // STEP_TWO
    
    BOXFolderItemsRequest *request = [[BOXContentClient defaultClient] folderItemsRequestWithID:self.folderID];
    [request performRequestWithCompletion:^(NSArray *items, NSError *error) {
        if (error == nil) {
            self.items = items;
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    BOXItem *currentItem = (BOXItem *)self.items[indexPath.row];
    cell.textLabel.text = currentItem.name;
    cell.detailTextLabel.text = [currentItem isFolder] ? @"Folder" : @"File";
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOXItem *selectedItem = (BOXItem *)self.items[indexPath.row];
    
    if ([selectedItem isFolder]) {
        FolderViewController *newListViewController = [[FolderViewController alloc] initWithFolderID:selectedItem.modelID];
        [self.navigationController pushViewController:newListViewController animated:YES];
    } else {
        ImageViewController *imageController = [[ImageViewController alloc] initWithFileID:selectedItem.modelID];
        [self.navigationController pushViewController:imageController animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = [[UITableViewHeaderFooterView alloc] init];
    
    if (self.items.count == 0) {
        header.textLabel.text = @"No files yet! Let's add some files from Box";
    } else {
        header.textLabel.text = [NSString stringWithFormat:@"%lld items", (long long) self.items.count];
    }
    
    return header;
}


@end
