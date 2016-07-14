//
//  ViewController.m
//  SCYandexDiskExample
//
//  Created by Maxim Kolesnik on 13.07.16.
//  Copyright © 2016 Sugar and Candy. All rights reserved.
//

#import "ViewController.h"
#import <SCYandexDisk/SCYandexDisk.h>
#import "SCFilesListViewController.h"

@interface ViewController () <SCYandexDiskAuthDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - SCYandexDiskAuthDelegate

- (NSString *)clientID {
    return @"625a5c86d5d64823b68b6720c83c5610";
}

- (NSString *)redirectURL {
    return @"https://oauth.yandex.ru/verification_code?status=ok&ncrnd=9879";
}

- (void)OAuthLoginSucceededWithToken:(SCYandexDiskAccessToken *)token {
    //NSLog(@"%@",token.tokenString);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)OAuthLoginFailedWithError:(NSError *)error {
    NSLog(@"%@",error);
    [self dismissViewControllerAnimated:YES completion:nil];

}

#pragma mark - Actions

- (IBAction)login:(id)sender {
    SCYandexDiskAuthViewController *vc = [[SCYandexDiskAuthViewController alloc] initWithDelegate:self];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)loadData:(id)sender {
    SCFilesListViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SCFilesListViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
