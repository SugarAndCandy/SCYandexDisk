//
//  SCYandexDiskDisk.h
//  SCYandexDisk
//
//  Created by Maxim Kolesnik on 13.07.16.
//  Copyright © 2016 Sugar and Candy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SCYandexDiskFolder;
@interface SCYandexDiskDisk : NSObject
@property(nonatomic, strong) NSArray<SCYandexDiskFolder *> *systemFolers;
@property(nonatomic, assign) NSInteger totalSpace;
@property(nonatomic, assign) NSInteger trashSize;
@property(nonatomic, assign) NSInteger usedSpace;
@end
