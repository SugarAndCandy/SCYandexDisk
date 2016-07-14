//
//  SCService+Disk.m
//  SCYandexDisk
//
//  Created by Maxim Kolesnik on 13.07.16.
//  Copyright © 2016 Sugar and Candy. All rights reserved.
//

#import "SCYandexDiskDisk.h"
#import "SCYandexDiskService+Disk.h"

@implementation SCYandexDiskService (Disk)

- (void)getUserDisk:(diskCompletionHandler)completion {
    [self getObjectsFromPath:@"disk"
                  parameters:nil
                  completion:^(BOOL success, id responseData, NSError *error) {
                      if (success) {
                          NSLog(@"success");
                          SCYandexDiskDisk *disk = [[SCYandexDiskDisk alloc] init];
                          disk.totalSpace = [[responseData objectForKey:@"total_space"] integerValue];
                          disk.trashSize = [[responseData objectForKey:@"trash_size"] integerValue];
                          disk.usedSpace = [[responseData objectForKey:@"used_space"] integerValue];
                          if (completion) {
                              completion(success, disk, error);
                          }
                      } else {
                          if (completion) {
                              completion(success, nil, error);
                          }
                      }
                  }];
}
@end
