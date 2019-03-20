//
//  RetriableAFNetworkingResponse.m
//  RetriableAFNetworking
//
//  Created by retriable on 2018/4/19.
//  Copyright © 2018年 retriable. All rights reserved.
//

#import "RetriableAFNetworkingResponse.h"

@interface RetriableAFNetworkingResponse()

@property (nonatomic,strong) NSURLSessionDataTask *URLSessionDataTask;
@property (nonatomic,strong) NSURLResponse        *response;
@property (nonatomic,strong) id                   responseObject;

@end

@implementation RetriableAFNetworkingResponse

- (instancetype)initWithURLSessionDataTask:(NSURLSessionDataTask*)URLSessionDataTask response:(NSURLResponse*)response responseObject:(id)responseObject{
    self=[self init];
    if (!self) return nil;
    self.URLSessionDataTask=URLSessionDataTask;
    self.response=response;
    self.responseObject=responseObject;
    return self;
}

@end
