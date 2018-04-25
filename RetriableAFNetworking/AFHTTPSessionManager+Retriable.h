//
//  AFHTTPSessionManager+Retriable.h
//  RetriableAFNetworking
//
//  Created by emsihyo on 2018/4/19.
//  Copyright © 2018年 emsihyo. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <Retriable/Retriable.h>

@interface AFHTTPSessionManager (Retriable)

@property (readonly) NSOperationQueue * _Nonnull retriable_operationQueue;

- (RetriableOperation * _Nonnull)GET:(NSString * _Nonnull)URLString
                parameters:(id _Nullable)parameters
                  progress:(void (^ _Nullable)(NSProgress * _Nonnull progress))downloadProgress
                   success:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task,id _Nullable responseObject))success
                   failure:(void (^ _Nullable)(NSURLSessionDataTask * _Nullable task,NSError * _Nullable error))failure
                retryAfter:(NSTimeInterval(^ _Nullable)(NSInteger currentRetryTime,NSError * _Nullable latestError))retryAfter;

- (RetriableOperation * _Nonnull)POST:(NSString * _Nonnull)URLString
                 parameters:(id _Nullable)parameters
                   progress:(void (^ _Nullable)(NSProgress * _Nonnull progress))uploadProgress success:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task,id _Nullable responseObject))success
                    failure:(void (^ _Nullable)(NSURLSessionDataTask * _Nullable task,NSError * _Nullable error))failure
                 retryAfter:(NSTimeInterval(^ _Nullable)(NSInteger currentRetryTime,NSError * _Nullable latestError))retryAfter;

- (RetriableOperation * _Nonnull)POST:(NSString * _Nonnull)URLString
                 parameters:(id _Nullable)parameters
  constructingBodyWithBlock:(void (^ _Nullable)(id<AFMultipartFormData> _Nonnull formData))block
                   progress:(void (^ _Nullable)(NSProgress * _Nonnull progress))uploadProgress
                    success:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task,id _Nullable responseObject))success
                    failure:(void (^ _Nullable)(NSURLSessionDataTask * _Nullable task,NSError * _Nullable error))failure
                 retryAfter:(NSTimeInterval(^ _Nullable)(NSInteger currentRetryTime,NSError * _Nullable latestError))retryAfter;

- (RetriableOperation * _Nonnull)HEAD:(NSString * _Nonnull)URLString
                 parameters:(id _Nullable)parameters
                    success:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task))success
                    failure:(void (^ _Nullable)(NSURLSessionDataTask * _Nullable task,NSError * _Nullable error))failure
                 retryAfter:(NSTimeInterval(^ _Nullable)(NSInteger currentRetryTime,NSError * _Nullable latestError))retryAfter;

- (RetriableOperation * _Nonnull)PUT:(NSString * _Nonnull)URLString
                parameters:(id _Nullable)parameters
                   success:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task,id _Nullable responseObject))success
                   failure:(void (^ _Nullable)(NSURLSessionDataTask * _Nullable task,NSError * _Nullable error))failure
                retryAfter:(NSTimeInterval(^ _Nullable)(NSInteger currentRetryTime,NSError * _Nullable latestError))retryAfter;

- (RetriableOperation * _Nonnull)PATCH:(NSString * _Nonnull)URLString
                  parameters:(id _Nullable)parameters
                     success:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task,id _Nullable responseObject))success
                     failure:(void (^ _Nullable)(NSURLSessionDataTask * _Nullable task,NSError * _Nullable error))failure
                  retryAfter:(NSTimeInterval(^ _Nullable)(NSInteger currentRetryTime,NSError * _Nullable latestError))retryAfter;

- (RetriableOperation * _Nonnull)DELETE:(NSString * _Nonnull)URLString
                   parameters:(id _Nullable)parameters
                      success:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task,id _Nullable responseObject))success
                      failure:(void (^ _Nullable)(NSURLSessionDataTask * _Nullable task,NSError * _Nullable error))failure
                   retryAfter:(NSTimeInterval(^ _Nullable)(NSInteger currentRetryTime,NSError * _Nullable latestError))retryAfter;

@end
