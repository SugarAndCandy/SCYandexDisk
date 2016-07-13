//
//  SCYandexDiskPagination.m
//  SCYandexDisk
//
//  Created by Maxim Kolesnik on 13.07.16.
//  Copyright © 2016 Sugar and Candy. All rights reserved.
//

#import "SCYandexDiskPagination.h"

@implementation SCYandexDiskPagination
- (instancetype)initWithLimit:(NSInteger)limit
                       offset:(NSInteger)offset
                        total:(NSInteger)total {
    self = [super init];
    if (self) {
        _limit = limit;
        _offset = offset;
        _total = total;
    }
    return self;
}

+ (instancetype)paginationWithLimit:(NSInteger)limit
                             offset:(NSInteger)offset
                              total:(NSInteger)total {
    return [[SCYandexDiskPagination alloc] initWithLimit:limit
                                                  offset:offset
                                                   total:total];
}
@end
