//
//  SCService+Disk.h
//  SCYandexDisk
//
//  Created by Maxim Kolesnik on 13.07.16.
//  Copyright © 2016 Sugar and Candy. All rights reserved.
//

#import "SCYandexDiskService.h"

@class SCYandexDiskDisk;
typedef void (^diskCompletionHandler)(BOOL success,
                                      SCYandexDiskDisk *disk,
                                      NSError *error);

@interface SCYandexDiskService (Disk)
- (void)getUserDisk:(diskCompletionHandler)completion;
@end
