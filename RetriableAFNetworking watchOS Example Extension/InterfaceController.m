//
//  InterfaceController.m
//  RetriableAFNetworking watchOS Example Extension
//
//  Created by emsihyo on 2018/4/25.
//  Copyright © 2018年 emsihyo. All rights reserved.
//

@import RetriableAFNetworking;

#import "InterfaceController.h"

@interface InterfaceController ()

@property (nonatomic,strong)AFHTTPSessionManager *sessionManager;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    [RetriableOperation setLogEnabled:YES];
    self.sessionManager=[AFHTTPSessionManager manager];
    [self.sessionManager GET:@"https://api.github.com/repos/emsihyo/RetriableAFNetworking/readme?n=v" headers:@{@"x-retriable-key":@"`1234567890-=\\][';/.~!@#$%^&*()_+|}{\":?><"} parameters:@{@"n1":@"v1"} progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
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
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



