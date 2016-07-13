//
//  SCFilesListViewController.m
//  SCYandexDiskExample
//
//  Created by Maxim Kolesnik on 14.07.16.
//  Copyright © 2016 Sugar and Candy. All rights reserved.
//

#import "SCFilesListViewController.h"
#import <SCYandexDisk/SCYandexDisk.h>

@interface SCFilesListViewController ()
@property (nonatomic, strong) NSArray *data;
@end

@implementation SCFilesListViewController
-(void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    NSString *path = self.path ? self.path : @"/";
    self.path = path;
    [[SCYandexDiskService sharedInstance] getFilesForPathWithoutLimit:path completion:^(BOOL success, NSArray<SCYandexDiskFile *> *files, NSArray<SCYandexDiskFolder *> *folders, SCYandexDiskPagination *pagination, NSError *error) {
        if (success) {
            NSLog(@"%@",files);
            NSLog(@"%@",folders);
            NSLog(@"%@",pagination);
            NSMutableArray *data = [NSMutableArray array];
            [data addObjectsFromArray:folders];
            [data addObjectsFromArray:files];
            self.data = [NSArray arrayWithArray:data];
            [self.tableView reloadData];
        } else {
            NSLog(@"%@",error);
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.data count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
    id<SCYandexDiskResource> resource = [self.data objectAtIndex:indexPath.row];
    if ([resource isKindOfClass:[SCYandexDiskFolder class]]) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        SCYandexDiskFile *file = (SCYandexDiskFile *)resource;
        cell.detailTextLabel.text = file.path;

    }
    cell.textLabel.text = resource.name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id<SCYandexDiskResource> resource = [self.data objectAtIndex:indexPath.row];
    if ([resource isKindOfClass:[SCYandexDiskFolder class]]) {
        SCFilesListViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SCFilesListViewController"];
        vc.path = [self.path stringByAppendingString:resource.name];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
