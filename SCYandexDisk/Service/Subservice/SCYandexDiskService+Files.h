//
//  SCService+Files.h
//  SCYandexDisk
//
//  Created by Maxim Kolesnik on 13.07.16.
//  Copyright © 2016 Sugar and Candy. All rights reserved.
//

#import "SCYandexDiskService.h"
@class SCYandexDiskFile, SCYandexDiskFolder, SCYandexDiskPagination;
typedef void (^filesCompletionHandler)(BOOL success, NSArray<SCYandexDiskFile *> *files, NSArray<SCYandexDiskFolder *> *folders, SCYandexDiskPagination *pagination, NSError *error);
typedef void (^URLyandexDiskCompletionHandler)(BOOL success, NSURL *url, NSError *error);

extern const struct FilesParameters {
    __unsafe_unretained NSString *limit;
    __unsafe_unretained NSString *offset;
    __unsafe_unretained NSString *path;
} FilesParameters;

@interface SCYandexDiskService (Files)
- (void)getFilesForPath:(NSString *)path completion:(filesCompletionHandler)completion;
- (void)getFilesForPathWithoutLimit:(NSString *)path completion:(filesCompletionHandler)completion;
- (void)getFilesForPath:(NSString *)path limit:(NSInteger)limit offset:(NSInteger)offset completion:(filesCompletionHandler)completion;

-(void)getDownloadLinkForPath:(NSString *)path completion:(URLyandexDiskCompletionHandler)completion;
-(void)publishFileForPath:(NSString *)path completion:(yandexDiskCompletionHandler)completion;
-(void)unpublishFileForPath:(NSString *)path completion:(yandexDiskCompletionHandler)completion;
@end
