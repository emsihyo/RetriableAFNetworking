//
//  ViewController.m
//  RetriableAFNetworkingExample
//
//  Created by emsihyo on 2018/4/19.
//  Copyright © 2018年 emsihyo. All rights reserved.
//

@import RetriableAFNetworking;

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong)AFHTTPSessionManager *HTTPSessionManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.HTTPSessionManager=[AFHTTPSessionManager manager];
    [self.HTTPSessionManager retriable_GET:@"https://api.github.com/user" parameters:nil progress:nil success:^(NSURLSessionDataTask * task, id responseObject) {
        
    } failure:^(NSURLSessionDataTask * task, NSError *error) {
        
    } retryAfter:^NSTimeInterval(id request, NSInteger currentRetryTime, NSError *latestError) {
        if (![latestError.domain isEqualToString:NSURLErrorDomain]) return 0;
        switch (latestError.code) {
            case NSURLErrorTimedOut:
            case NSURLErrorNetworkConnectionLost:
            case NSURLErrorNotConnectedToInternet:
                return 2;
            default: return 0;
        }
    }];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
