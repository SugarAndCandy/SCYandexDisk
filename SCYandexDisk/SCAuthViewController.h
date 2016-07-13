//
//  SCYandexDisk.h
//  SCYandexDisk
//
//  Created by Maxim Kolesnik on 13.07.16.
//  Copyright © 2016 Sugar and Candy. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "SCAuthProtocol.h"

@interface SCAuthViewController : UIViewController <SCAuthProtocol, UIWebViewDelegate>

- (instancetype)initWithDelegate:(id<SCAuthDelegate>)delegate;

@end
