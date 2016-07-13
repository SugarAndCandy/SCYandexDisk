//
//  SCYandexDisk.h
//  SCYandexDisk
//
//  Created by Maxim Kolesnik on 13.07.16.
//  Copyright © 2016 Sugar and Candy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCYandexDiskAuthProtocol.h"

@interface SCYandexDiskAuthViewController: UIViewController<SCYandexDiskAuthProtocol, UIWebViewDelegate>

- (instancetype)initWithDelegate:(id<SCYandexDiskAuthDelegate>)delegate;

@end
