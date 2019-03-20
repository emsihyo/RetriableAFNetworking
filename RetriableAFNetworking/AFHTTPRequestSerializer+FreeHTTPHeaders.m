//
//  AFHTTPRequestSerializer+FreeHTTPHeaders.m
//  RetriableAFNetworking
//
//  Created by retriable on 2018/4/13.
//  Copyright © 2018年 retriable. All rights reserved.
//

#import <JRSwizzle/JRSwizzle.h>

#import "AFHTTPRequestSerializer+FreeHTTPHeaders.h"
#import "AFHTTPSessionManager+FreeHTTPHeaders.h"

@implementation AFHTTPRequestSerializer (FreeHTTPHeaders)

- (NSURLRequest *)free_http_headers_requestBySerializingRequest:(NSURLRequest *)req withParameters:(nullable id)parameters error:(NSError * _Nullable __autoreleasing *)error{
    NSMutableURLRequest *request=[req mutableCopy];
    NSString *target;NSDictionary *headers;
    free_http_headers_decode(req.URL.absoluteString, &target, &headers);
    request.URL=[NSURL URLWithString:target];
    request=[[self free_http_headers_requestBySerializingRequest:request withParameters:parameters error:error] mutableCopy];
    [headers enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [request setValue:obj forHTTPHeaderField:key];
    }];
    return request;
}

+ (void)load{
    [self jr_swizzleMethod:@selector(requestBySerializingRequest:withParameters:error:) withMethod:@selector(free_http_headers_requestBySerializingRequest:withParameters:error:) error:nil];
}

@end

