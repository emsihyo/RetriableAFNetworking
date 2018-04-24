//
//  AFHTTPSessionManager+FreeHTTPHeaders.h
//  RetriableAFNetworking
//
//  Created by emsihyo on 2018/4/19.
//  Copyright © 2018年 emsihyo. All rights reserved.
//

#import <RetriableAFNetworking/RetriableAFNetworking.h>

FOUNDATION_EXPORT void free_http_headers_encode(NSString *source,NSString **target,NSDictionary *headers);
FOUNDATION_EXPORT void free_http_headers_decode(NSString *source,NSString **target,NSDictionary **headers);

@interface AFHTTPSessionManager (FreeHTTPHeaders)

- (RetriableOperation*)GET:(NSString *)URLString
                   headers:(NSDictionary*)headers
                parameters:(id)parameters
                  progress:(void (^)(NSProgress *progress))downloadProgress
                   success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                   failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
                retryAfter:(NSTimeInterval (^)(NSInteger currentRetryTime, NSError * latestError))retryAfter;

- (RetriableOperation*)POST:(NSString *)URLString
                    headers:(NSDictionary*)headers
                 parameters:(id)parameters
                   progress:(void (^)(NSProgress *progress))uploadProgress
                    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
                 retryAfter:(NSTimeInterval (^)(NSInteger currentRetryTime, NSError *latestError))retryAfter;

- (RetriableOperation*)POST:(NSString *)URLString
                    headers:(NSDictionary*)headers
                 parameters:(id)parameters
  constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block
                   progress:(void (^)(NSProgress *progress))uploadProgress
                    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
                 retryAfter:(NSTimeInterval (^)(NSInteger currentRetryTime, NSError *latestError))retryAfter;

- (RetriableOperation*)HEAD:(NSString *)URLString
                    headers:(NSDictionary*)headers
                 parameters:(id)parameters
                    success:(void (^)(NSURLSessionDataTask *task))success
                    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
                 retryAfter:(NSTimeInterval (^)(NSInteger currentRetryTime, NSError * latestError))retryAfter;

- (RetriableOperation*)PUT:(NSString *)URLString
                   headers:(NSDictionary*)headers
                parameters:(id)parameters
                   success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                   failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
                retryAfter:(NSTimeInterval (^)(NSInteger currentRetryTime, NSError *latestError))retryAfter;

- (RetriableOperation*)PATCH:(NSString *)URLString
                     headers:(NSDictionary*)headers
                  parameters:(id)parameters
                     success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                     failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
                  retryAfter:(NSTimeInterval (^)(NSInteger currentRetryTime, NSError *latestError))retryAfter;

- (RetriableOperation*)DELETE:(NSString *)URLString
                      headers:(NSDictionary*)headers
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
                   retryAfter:(NSTimeInterval (^)(NSInteger currentRetryTime, NSError *latestError))retryAfter;

@end
