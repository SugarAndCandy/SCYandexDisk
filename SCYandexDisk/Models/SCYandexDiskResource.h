//
//  SCYandexDiskResource.h
//  SCYandexDisk
//
//  Created by Maxim Kolesnik on 13.07.16.
//  Copyright © 2016 Sugar and Candy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SCYandexDiskResource<NSObject>
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSString *created;
@property (nonatomic, strong) NSString *modified;
@end
