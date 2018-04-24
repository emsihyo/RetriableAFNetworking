//
//  ViewController.m
//  RetriableAFNetworking macOS Example
//
//  Created by emsihyo on 2018/4/21.
//  Copyright © 2018年 emsihyo. All rights reserved.
//
@import Retriable;
@import RetriableAFNetworking;

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [RetriableOperation setLogEnabled:YES];
    self.sessionManager=[AFHTTPSessionManager manager];
    [self.sessionManager GET:@"https://api.github.com/repos/emsihyo/RetriableAFNetworking/readme" headers:@{@"x-header-1":@"x-header-1"} parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"\nurl:%@\nheaders: %@",task.currentRequest.URL,[[task currentRequest] allHTTPHeaderFields]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"\nurl:%@\nheaders: %@",task.currentRequest.URL,[[task currentRequest] allHTTPHeaderFields]);
    } retryAfter:^NSTimeInterval(NSInteger currentRetryTime, NSError *latestError) {
        if(![latestError.domain isEqualToString:NSURLErrorDomain]) return 0;
        switch (latestError.code) {
            case NSURLErrorTimedOut:
            case NSURLErrorNotConnectedToInternet:
            case NSURLErrorNetworkConnectionLost: return 5;
            default: return 0;
        }
    }];
    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
