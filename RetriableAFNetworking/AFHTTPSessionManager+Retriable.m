//
//  AFHTTPSessionManager+Retriable.m
//  RetriableAFNetworking
//
//  Created by retriable on 2018/4/19.
//  Copyright © 2018年 retriable. All rights reserved.
//

#import <objc/runtime.h>

#import "AFHTTPSessionManager+Retriable.h"
#import "RetriableAFNetworkingResponse.h"
#import "AFURLSessionManager+Retriable.h"

@implementation AFHTTPSessionManager (Retriable)

- (RetriableOperation*)GET:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress *))downloadProgress success:(void (^)(NSURLSessionDataTask *,id))success failure:(void (^)(NSURLSessionDataTask *,NSError *))failure retryAfter:(NSTimeInterval(^)(NSInteger currentRetryTime,NSError *latestError))retryAfter{
    __block NSURLSessionDataTask *task;
    __weak typeof(self) weakSelf=self;
    RetriableOperation *operation=[[RetriableOperation alloc]initWithCompletion:^(RetriableAFNetworkingResponse *response,NSError *latestError) {
        if(latestError){
            if (failure) failure(response.URLSessionDataTask,latestError);
        }else{
            if (success) success(response.URLSessionDataTask,response.responseObject);
        }
    } retryAfter:retryAfter start:^(void (^completion)(RetriableAFNetworkingResponse *response,NSError *error)) {
        task=[weakSelf GET:URLString parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * task,id  responseObject) {
            RetriableAFNetworkingResponse *response=[[RetriableAFNetworkingResponse alloc]initWithURLSessionDataTask:task response:nil responseObject:responseObject];
            completion(response,nil);
        } failure:^(NSURLSessionDataTask * task,NSError * error) {
            RetriableAFNetworkingResponse *response=[[RetriableAFNetworkingResponse alloc]initWithURLSessionDataTask:task response:nil responseObject:nil];
            completion(response,error);
        }];
    } cancel:^ {
        if (!task) return;
        [task cancel];
        task=nil;
    } cancelledErrorTemplates:nil];
    [self.retriable_operationQueue addOperation:operation];
    return operation;
}

- (RetriableOperation*)POST:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress *))uploadProgress success:(void (^)(NSURLSessionDataTask *,id))success failure:(void (^)(NSURLSessionDataTask *,NSError *))failure retryAfter:(NSTimeInterval(^)(NSInteger currentRetryTime,NSError *latestError))retryAfter{
    __block NSURLSessionDataTask *task;
    __weak typeof(self) weakSelf=self;
    RetriableOperation *operation=[[RetriableOperation alloc]initWithCompletion:^(RetriableAFNetworkingResponse *response,NSError *latestError) {
        if(latestError){
            if (failure) failure(response.URLSessionDataTask,latestError);
        }else{
            if (success) success(response.URLSessionDataTask,response.responseObject);
        }
    } retryAfter:retryAfter start:^(void (^completion)(RetriableAFNetworkingResponse *response,NSError *error)) {
        task=[weakSelf POST:URLString parameters:parameters progress:uploadProgress success:^(NSURLSessionDataTask * task,id  responseObject) {
            RetriableAFNetworkingResponse *response=[[RetriableAFNetworkingResponse alloc]initWithURLSessionDataTask:task response:nil responseObject:responseObject];
            completion(response,nil);
        } failure:^(NSURLSessionDataTask * task,NSError * error) {
            RetriableAFNetworkingResponse *response=[[RetriableAFNetworkingResponse alloc]initWithURLSessionDataTask:task response:nil responseObject:nil];
            completion(response,error);
        }];
    } cancel:^{
        if (!task) return;
        [task cancel];
        task=nil;
    } cancelledErrorTemplates:nil];
    [self.retriable_operationQueue addOperation:operation];
    return operation;
}

- (RetriableOperation*)POST:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block progress:(void (^)(NSProgress *))uploadProgress success:(void (^)(NSURLSessionDataTask *,id))success failure:(void (^)(NSURLSessionDataTask *,NSError *))failure retryAfter:(NSTimeInterval(^)(NSInteger currentRetryTime,NSError *latestError))retryAfter{
    __block NSURLSessionDataTask *task;
    __weak typeof(self) weakSelf=self;
    RetriableOperation *operation=[[RetriableOperation alloc]initWithCompletion:^(RetriableAFNetworkingResponse *response,NSError *latestError) {
        if(latestError){
            if (failure) failure(response.URLSessionDataTask,latestError);
        }else{
            if (success) success(response.URLSessionDataTask,response.responseObject);
        }
    } retryAfter:retryAfter start:^(void (^completion)(RetriableAFNetworkingResponse *response,NSError *error)) {
        task=[weakSelf POST:URLString parameters:parameters constructingBodyWithBlock:block progress:uploadProgress success:^(NSURLSessionDataTask * task,id  responseObject) {
            RetriableAFNetworkingResponse *response=[[RetriableAFNetworkingResponse alloc]initWithURLSessionDataTask:task response:nil responseObject:responseObject];
            completion(response,nil);
        } failure:^(NSURLSessionDataTask * task,NSError * error) {
            RetriableAFNetworkingResponse *response=[[RetriableAFNetworkingResponse alloc]initWithURLSessionDataTask:task response:nil responseObject:nil];
            completion(response,error);
        }];
    } cancel:^{
        if (!task) return;
        [task cancel];
        task=nil;
    } cancelledErrorTemplates:nil];
    [self.retriable_operationQueue addOperation:operation];
    return operation;
}

- (RetriableOperation*)HEAD:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *))success failure:(void (^)(NSURLSessionDataTask *,NSError *))failure retryAfter:(NSTimeInterval(^)(NSInteger currentRetryTime,NSError *latestError))retryAfter{
    __block NSURLSessionDataTask *task;
    __weak typeof(self) weakSelf=self;
    RetriableOperation *operation=[[RetriableOperation alloc]initWithCompletion:^(RetriableAFNetworkingResponse *response,NSError *latestError) {
        if(latestError){
            if (failure) failure(response.URLSessionDataTask,latestError);
        }else{
            if (success) success(response.URLSessionDataTask);
        }
    } retryAfter:retryAfter start:^(void (^completion)(RetriableAFNetworkingResponse *response,NSError *error)) {
        task=[weakSelf HEAD:URLString parameters:parameters success:^(NSURLSessionDataTask * task) {
            RetriableAFNetworkingResponse *response=[[RetriableAFNetworkingResponse alloc]initWithURLSessionDataTask:task response:nil responseObject:nil];
            completion(response,nil);
        } failure:^(NSURLSessionDataTask * task,NSError * error) {
            RetriableAFNetworkingResponse *response=[[RetriableAFNetworkingResponse alloc]initWithURLSessionDataTask:task response:nil responseObject:nil];
            completion(response,error);
        }];
    } cancel:^{
        if (!task) return;
        [task cancel];
        task=nil;
    } cancelledErrorTemplates:nil];
    [self.retriable_operationQueue addOperation:operation];
    return operation;
}

- (RetriableOperation*)PUT:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *,id))success failure:(void (^)(NSURLSessionDataTask *,NSError *))failure retryAfter:(NSTimeInterval(^)(NSInteger currentRetryTime,NSError *latestError))retryAfter{
    __block NSURLSessionDataTask *task;
    __weak typeof(self) weakSelf=self;
    RetriableOperation *operation=[[RetriableOperation alloc]initWithCompletion:^(RetriableAFNetworkingResponse *response,NSError *latestError) {
        if(latestError){
            if (failure) failure(response.URLSessionDataTask,latestError);
        }else{
            if (success) success(response.URLSessionDataTask,response.responseObject);
        }
    } retryAfter:retryAfter start:^(void (^completion)(RetriableAFNetworkingResponse *response,NSError *error)) {
        task=[weakSelf PUT:URLString parameters:parameters success:^(NSURLSessionDataTask * task,id  responseObject) {
            RetriableAFNetworkingResponse *response=[[RetriableAFNetworkingResponse alloc]initWithURLSessionDataTask:task response:nil responseObject:responseObject];
            completion(response,nil);
        } failure:^(NSURLSessionDataTask * task,NSError * error) {
            RetriableAFNetworkingResponse *response=[[RetriableAFNetworkingResponse alloc]initWithURLSessionDataTask:task response:nil responseObject:nil];
            completion(response,error);
        }];
    } cancel:^{
        if (!task) return;
        [task cancel];
        task=nil;
    } cancelledErrorTemplates:nil];
    [self.retriable_operationQueue addOperation:operation];
    return operation;
}

- (RetriableOperation*)PATCH:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *,id))success failure:(void (^)(NSURLSessionDataTask *,NSError *))failure retryAfter:(NSTimeInterval(^)(NSInteger currentRetryTime,NSError *latestError))retryAfter{
    __block NSURLSessionDataTask *task;
    __weak typeof(self) weakSelf=self;
    RetriableOperation *operation=[[RetriableOperation alloc]initWithCompletion:^(RetriableAFNetworkingResponse *response,NSError *latestError) {
        if(latestError){
            if (failure) failure(response.URLSessionDataTask,latestError);
        }else{
            if (success) success(response.URLSessionDataTask,response.responseObject);
        }
    } retryAfter:retryAfter start:^(void (^completion)(RetriableAFNetworkingResponse *response,NSError *error)) {
        task=[weakSelf PATCH:URLString parameters:parameters success:^(NSURLSessionDataTask * task,id  responseObject) {
            RetriableAFNetworkingResponse *response=[[RetriableAFNetworkingResponse alloc]initWithURLSessionDataTask:task response:nil responseObject:responseObject];
            completion(response,nil);
        } failure:^(NSURLSessionDataTask * task,NSError * error) {
            RetriableAFNetworkingResponse *response=[[RetriableAFNetworkingResponse alloc]initWithURLSessionDataTask:task response:nil responseObject:nil];
            completion(response,error);
        }];
    } cancel:^{
        if (!task) return;
        [task cancel];
        task=nil;
    } cancelledErrorTemplates:nil];
    [self.retriable_operationQueue addOperation:operation];
    return operation;
}

- (RetriableOperation*)DELETE:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *,id))success failure:(void (^)(NSURLSessionDataTask *,NSError *))failure retryAfter:(NSTimeInterval(^)(NSInteger currentRetryTime,NSError *latestError))retryAfter{
    __block NSURLSessionDataTask *task;
    __weak typeof(self) weakSelf=self;
    RetriableOperation *operation=[[RetriableOperation alloc]initWithCompletion:^(RetriableAFNetworkingResponse *response,NSError *latestError) {
        if(latestError){
            if (failure) failure(response.URLSessionDataTask,latestError);
        }else{
            if (success) success(response.URLSessionDataTask,response.responseObject);
        }
    } retryAfter:retryAfter start:^(void (^completion)(RetriableAFNetworkingResponse *response,NSError *error)) {
        task=[weakSelf DELETE:URLString parameters:parameters success:^(NSURLSessionDataTask * task,id  responseObject) {
            RetriableAFNetworkingResponse *response=[[RetriableAFNetworkingResponse alloc]initWithURLSessionDataTask:task response:nil responseObject:responseObject];
            completion(response,nil);
        } failure:^(NSURLSessionDataTask * task,NSError * error) {
            RetriableAFNetworkingResponse *response=[[RetriableAFNetworkingResponse alloc]initWithURLSessionDataTask:task response:nil responseObject:nil];
            completion(response,error);
        }];
    } cancel:^{
        if (!task) return;
        [task cancel];
        task=nil;
    } cancelledErrorTemplates:nil];
    [self.retriable_operationQueue addOperation:operation];
    return operation;
}

@end
