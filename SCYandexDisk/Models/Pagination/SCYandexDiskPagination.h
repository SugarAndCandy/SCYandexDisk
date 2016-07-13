//
//  SCYandexDiskPagination.h
//  SCYandexDisk
//
//  Created by Maxim Kolesnik on 13.07.16.
//  Copyright © 2016 Sugar and Candy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCYandexDiskPagination : NSObject
@property (nonatomic, assign) NSInteger limit;
@property (nonatomic, assign) NSInteger offset;
@property (nonatomic, assign) NSInteger total;

- (instancetype)initWithLimit:(NSInteger)limit
                       offset:(NSInteger)offset
                        total:(NSInteger)total;

+ (instancetype)paginationWithLimit:(NSInteger)limit
                             offset:(NSInteger)offset
                              total:(NSInteger)total;
@end
