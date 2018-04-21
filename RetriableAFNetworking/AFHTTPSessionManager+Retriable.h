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

@property (readonly) NSOperationQueue *retriable_operationQueue;

- (RetriableOperation*)GET:(NSString *)URLString
                parameters:(id)parameters
                  progress:(void (^)(NSProgress *progress))downloadProgress
                   success:(void (^)(NSURLSessionDataTask *task,id responseObject))success
                   failure:(void (^)(NSURLSessionDataTask *task,NSError *error))failure
                retryAfter:(NSTimeInterval(^)(NSInteger currentRetryTime,NSError *latestError))retryAfter;

- (RetriableOperation*)POST:(NSString *)URLString
                 parameters:(id)parameters
                   progress:(void (^)(NSProgress *progress))uploadProgress success:(void (^)(NSURLSessionDataTask *task,id responseObject))success
                    failure:(void (^)(NSURLSessionDataTask *task,NSError *error))failure
                 retryAfter:(NSTimeInterval(^)(NSInteger currentRetryTime,NSError *latestError))retryAfter;

- (RetriableOperation*)POST:(NSString *)URLString
                 parameters:(id)parameters
  constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block
                   progress:(void (^)(NSProgress *progress))uploadProgress
                    success:(void (^)(NSURLSessionDataTask *task,id responseObject))success
                    failure:(void (^)(NSURLSessionDataTask *task,NSError *error))failure
                 retryAfter:(NSTimeInterval(^)(NSInteger currentRetryTime,NSError *latestError))retryAfter;

- (RetriableOperation*)HEAD:(NSString *)URLString
                 parameters:(id)parameters
                    success:(void (^)(NSURLSessionDataTask *task))success
                    failure:(void (^)(NSURLSessionDataTask *task,NSError *error))failure
                 retryAfter:(NSTimeInterval(^)(NSInteger currentRetryTime,NSError *latestError))retryAfter;

- (RetriableOperation*)PUT:(NSString *)URLString
                parameters:(id)parameters
                   success:(void (^)(NSURLSessionDataTask *task,id responseObject))success
                   failure:(void (^)(NSURLSessionDataTask *task,NSError *error))failure
                retryAfter:(NSTimeInterval(^)(NSInteger currentRetryTime,NSError *latestError))retryAfter;

- (RetriableOperation*)PATCH:(NSString *)URLString
                  parameters:(id)parameters
                     success:(void (^)(NSURLSessionDataTask *task,id responseObject))success
                     failure:(void (^)(NSURLSessionDataTask *task,NSError *error))failure
                  retryAfter:(NSTimeInterval(^)(NSInteger currentRetryTime,NSError *latestError))retryAfter;

- (RetriableOperation*)DELETE:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task,id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task,NSError *error))failure
                   retryAfter:(NSTimeInterval(^)(NSInteger currentRetryTime,NSError *latestError))retryAfter;

@end
