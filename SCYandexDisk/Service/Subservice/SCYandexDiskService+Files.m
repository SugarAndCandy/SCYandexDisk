//
//  SCService+Files.m
//  SCYandexDisk
//
//  Created by Maxim Kolesnik on 13.07.16.
//  Copyright © 2016 Sugar and Candy. All rights reserved.
//

#import "SCYandexDiskFile.h"
#import "SCYandexDiskFolder.h"
#import "SCYandexDiskPagination.h"
#import "SCYandexDiskService+Files.h"

static NSString *const DISK_PATH = @"disk";
static NSString *const RESOURCES_PATH = @"resources";
static NSString *const TOTAL = @"total";
static NSString *const EMBEDDED = @"_embedded";
static NSString *const ITEMS = @"items";
static NSString *const TYPE = @"type";

const struct FilesParameters FilesParameters = {
    .limit = @"limit",
    .offset = @"offset",
    .path = @"path"
};

@implementation SCYandexDiskService (Files)

- (void)getFilesForPath:(NSString *)path
             completion:(filesCompletionHandler)completion {
    [self getFilesForPath:path limit:20 offset:0 completion:completion];
}

- (void)getFilesForPathWithoutLimit:(NSString *)path
                         completion:(filesCompletionHandler)completion {
    [self getFilesForPath:path
               completion:^(BOOL success, NSArray<SCYandexDiskFile *> *files,
                            NSArray<SCYandexDiskFolder *> *folders,
                            SCYandexDiskPagination *pagination, NSError *error) {
                   [self getFilesForPath:path
                                   limit:pagination.total
                                  offset:0
                              completion:completion];
               }];
}

- (void)getFilesForPath:(NSString *)path
                  limit:(NSInteger)limit
                 offset:(NSInteger)offset
             completion:(filesCompletionHandler)completion {
    [self getObjectsFromPath:[NSString stringWithFormat:@"%@/%@", DISK_PATH, RESOURCES_PATH]
                  parameters:@{FilesParameters.path : path,
                               FilesParameters.limit : @(limit),
                               FilesParameters.offset : @(offset)}
                  completion:^(BOOL success, id responseData, NSError *error) {
                      if (success) {
                          NSLog(@"%@", responseData);
                          NSDictionary *embedded = [responseData objectForKey:EMBEDDED];
                          NSArray *items = [embedded objectForKey:ITEMS];
                          NSMutableArray *files = [NSMutableArray array];
                          NSMutableArray *folders = [NSMutableArray array];
                          for (NSDictionary *item in items) {
                              if ([[item objectForKey:TYPE] isEqualToString:file]) {
                                  SCYandexDiskFile *file = [SCYandexDiskFile fileFromDictionary:item];
                                  [files addObject:file];
                              } else if ([[item objectForKey:TYPE] isEqualToString:dir]) {
                                  SCYandexDiskFolder *folder = [SCYandexDiskFolder folderFromDictionary:item];
                                  [folders addObject:folder];
                              }
                          }
                          NSInteger *limit = [[embedded objectForKey:FilesParameters.limit] integerValue];
                          NSInteger *offset = [[embedded objectForKey:FilesParameters.offset] integerValue];
                          NSInteger *total = [[embedded objectForKey:TOTAL] integerValue];
                          SCYandexDiskPagination *pagination =
                          [SCYandexDiskPagination paginationWithLimit:limit
                                                               offset:offset
                                                                total:total];
                          if (completion) {
                              completion(YES, [NSArray arrayWithArray:files],
                                         [NSArray arrayWithArray:folders],
                                         pagination, nil);
                          }
                      } else {
                          if (completion) {
                              completion(NO, nil, nil, nil, error);
                          }
                      }
                  }];
}
@end
