//
//  AFURLSessionManager+Retriable.m
//  RetriableAFNetworking
//
//  Created by emsihyo on 2018/5/2.
//  Copyright © 2018年 emsihyo. All rights reserved.
//

#import "AFURLSessionManager+Retriable.h"
#import "RetriableAFNetworkingResponse.h"
#import <objc/runtime.h>

@implementation AFURLSessionManager (Retriable)

- (NSOperationQueue*)retriable_operationQueue{
    NSOperationQueue *queue=objc_getAssociatedObject(self,@selector(retriable_operationQueue));
    if (queue) return queue;
    queue=[[NSOperationQueue alloc]init];
    objc_setAssociatedObject(self,@selector(retriable_operationQueue),queue,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return queue;
}

- (RetriableOperation *)dataTaskWithRequest:(NSURLRequest *)request
                             uploadProgress:(nullable void (^)(NSProgress *uploadProgress))uploadProgressBlock
                           downloadProgress:(nullable void (^)(NSProgress *downloadProgress))downloadProgressBlock
                          completionHandler:(nullable void (^)(NSURLResponse *response, id _Nullable responseObject,  NSError * _Nullable error))completionHandler
                                 retryAfter:(NSTimeInterval(^ _Nullable)(NSInteger currentRetryTime,NSError * _Nullable latestError))retryAfter{
    __block NSURLSessionDataTask *task;
    __weak typeof(self) weakSelf=self;
    RetriableOperation *operation=[[RetriableOperation alloc]initWithCompletion:^(RetriableAFNetworkingResponse *response,NSError *latestError) {
        if (completionHandler) completionHandler(response.response,response.responseObject,latestError);
    } retryAfter:retryAfter start:^(void (^completion)(RetriableAFNetworkingResponse *response,NSError *error)) {
        task=[weakSelf dataTaskWithRequest:request uploadProgress:uploadProgressBlock downloadProgress:downloadProgressBlock completionHandler:^(NSURLResponse *response, id  _Nullable responseObject, NSError * _Nullable error) {
            completion([[RetriableAFNetworkingResponse alloc]initWithURLSessionDataTask:nil response:response responseObject:responseObject],error);
        }];
    } cancel:^{
        if (!task) return;
        [task cancel];
        task=nil;
    } cancelledErrorTemplates:nil];
    [self.retriable_operationQueue addOperation:operation];
    return operation;
}

- (RetriableOperation * _Nullable)uploadTaskWithRequest:(NSURLRequest * _Nonnull)request
                                               fromFile:(NSURL * _Nonnull)fileURL
                                               progress:(void (^_Nullable)(NSProgress * _Nullable uploadProgress))uploadProgressBlock
                                      completionHandler:(void (^_Nullable)(NSURLResponse * _Nullable response, id _Nullable responseObject, NSError  * _Nullable error))completionHandler
                                             retryAfter:(NSTimeInterval(^ _Nullable)(NSInteger currentRetryTime,NSError * _Nullable latestError))retryAfter{
    __block NSURLSessionUploadTask *task;
    __weak typeof(self) weakSelf=self;
    RetriableOperation *operation=[[RetriableOperation alloc]initWithCompletion:^(RetriableAFNetworkingResponse *response,NSError *latestError) {
        if (completionHandler) completionHandler(response.response,response.responseObject,latestError);
    } retryAfter:retryAfter start:^(void (^completion)(RetriableAFNetworkingResponse *response,NSError *error)) {
        task=[weakSelf uploadTaskWithRequest:request fromFile:fileURL progress:uploadProgressBlock completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            completion([[RetriableAFNetworkingResponse alloc]initWithURLSessionDataTask:nil response:response responseObject:responseObject],error);
        }];
    } cancel:^{
        if (!task) return;
        [task cancel];
        task=nil;
    } cancelledErrorTemplates:nil];
    [self.retriable_operationQueue addOperation:operation];
    return operation;
}

- (RetriableOperation * _Nullable)uploadTaskWithRequest:(NSURLRequest * _Nonnull)request
                                               fromData:(NSData * _Nonnull)bodyData
                                               progress:(void (^_Nullable)(NSProgress * _Nullable uploadProgress))uploadProgressBlock
                                      completionHandler:(void (^_Nullable)(NSURLResponse * _Nullable response, id _Nullable responseObject, NSError * _Nullable error))completionHandler
                                             retryAfter:(NSTimeInterval(^ _Nullable)(NSInteger currentRetryTime,NSError * _Nullable latestError))retryAfter{
    __block NSURLSessionUploadTask *task;
    __weak typeof(self) weakSelf=self;
    RetriableOperation *operation=[[RetriableOperation alloc]initWithCompletion:^(RetriableAFNetworkingResponse *response,NSError *latestError) {
        if (completionHandler) completionHandler(response.response,response.responseObject,latestError);
    } retryAfter:retryAfter start:^(void (^completion)(RetriableAFNetworkingResponse *response,NSError *error)) {
        task=[weakSelf uploadTaskWithRequest:request fromData:bodyData progress:uploadProgressBlock completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            completion([[RetriableAFNetworkingResponse alloc]initWithURLSessionDataTask:nil response:response responseObject:responseObject],error);
        }];
    } cancel:^{
        if (!task) return;
        [task cancel];
        task=nil;
    } cancelledErrorTemplates:nil];
    [self.retriable_operationQueue addOperation:operation];
    return operation;
}

- (RetriableOperation * _Nullable)uploadTaskWithStreamedRequest:(NSURLRequest * _Nonnull)request
                                                       progress:(void (^ _Nullable)(NSProgress * _Nullable uploadProgress))uploadProgressBlock
                                              completionHandler:(void (^ _Nullable)(NSURLResponse * _Nullable response, id _Nullable responseObject, NSError * _Nullable error))completionHandler
                                                     retryAfter:(NSTimeInterval(^ _Nullable)(NSInteger currentRetryTime,NSError * _Nullable latestError))retryAfter{
    __block NSURLSessionUploadTask *task;
    __weak typeof(self) weakSelf=self;
    RetriableOperation *operation=[[RetriableOperation alloc]initWithCompletion:^(RetriableAFNetworkingResponse *response,NSError *latestError) {
        if (completionHandler) completionHandler(response.response,response.responseObject,latestError);
    } retryAfter:retryAfter start:^(void (^completion)(RetriableAFNetworkingResponse *response,NSError *error)) {
        task=[weakSelf uploadTaskWithStreamedRequest:request progress:uploadProgressBlock completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            completion([[RetriableAFNetworkingResponse alloc]initWithURLSessionDataTask:nil response:response responseObject:responseObject],error);
        }];
    } cancel:^{
        if (!task) return;
        [task cancel];
        task=nil;
    } cancelledErrorTemplates:nil];
    [self.retriable_operationQueue addOperation:operation];
    return operation;
}

- (RetriableOperation * _Nullable)downloadTaskWithRequest:(NSURLRequest * _Nonnull)request
                                                 progress:(void (^_Nullable)(NSProgress * _Nullable downloadProgress))downloadProgressBlock
                                              destination:(NSURL * _Nullable (^_Nullable)(NSURL * _Nullable targetPath, NSURLResponse * _Nullable response))destination
                                        completionHandler:(void (^_Nullable)(NSURLResponse * _Nullable response, NSURL * _Nullable filePath, NSError * _Nullable error))completionHandler
                                               retryAfter:(NSTimeInterval(^ _Nullable)(NSInteger currentRetryTime,NSError * _Nullable latestError))retryAfter{
    __block NSURLSessionDownloadTask *task;
    __weak typeof(self) weakSelf=self;
    RetriableOperation *operation=[[RetriableOperation alloc]initWithCompletion:^(RetriableAFNetworkingResponse *response,NSError *latestError) {
        if (completionHandler) completionHandler(response.response,response.responseObject,latestError);
    } retryAfter:retryAfter start:^(void (^completion)(RetriableAFNetworkingResponse *response,NSError *error)) {
        task=[weakSelf downloadTaskWithRequest:request progress:downloadProgressBlock destination:destination completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            completion([[RetriableAFNetworkingResponse alloc]initWithURLSessionDataTask:nil response:response responseObject:responseObject],error);
        }];
    } cancel:^{
        if (!task) return;
        [task cancel];
        task=nil;
    } cancelledErrorTemplates:nil];
    [self.retriable_operationQueue addOperation:operation];
    return operation;
}
- (RetriableOperation * _Nullable)downloadTaskWithResumeData:(NSData * _Nonnull )resumeData
                                                    progress:(void (^_Nullable)(NSProgress * _Nullable downloadProgress))downloadProgressBlock
                                                 destination:(NSURL * _Nullable (^_Nullable)(NSURL * _Nullable targetPath, NSURLResponse * _Nullable response))destination
                                           completionHandler:(void (^_Nullable)(NSURLResponse * _Nullable response, NSURL * _Nullable filePath, NSError * _Nullable error))completionHandler
                                                  retryAfter:(NSTimeInterval(^ _Nullable)(NSInteger currentRetryTime,NSError * _Nullable latestError))retryAfter{
    __block NSURLSessionDownloadTask *task;
    __weak typeof(self) weakSelf=self;
    RetriableOperation *operation=[[RetriableOperation alloc]initWithCompletion:^(RetriableAFNetworkingResponse *response,NSError *latestError) {
        if (completionHandler) completionHandler(response.response,response.responseObject,latestError);
    } retryAfter:retryAfter start:^(void (^completion)(RetriableAFNetworkingResponse *response,NSError *error)) {
        task=[weakSelf downloadTaskWithResumeData:resumeData progress:downloadProgressBlock destination:destination completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            completion([[RetriableAFNetworkingResponse alloc]initWithURLSessionDataTask:nil response:response responseObject:responseObject],error);
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
