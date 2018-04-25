//
//  AFHTTPSessionManager+FreeHTTPHeaders.h
//  RetriableAFNetworking
//
//  Created by emsihyo on 2018/4/19.
//  Copyright © 2018年 emsihyo. All rights reserved.
//


#import <RetriableAFNetworking/RetriableAFNetworking.h>

FOUNDATION_EXPORT void free_http_headers_encode(NSString * _Nonnull source,NSString * _Nullable * _Nullable target,NSDictionary * _Nullable headers);
FOUNDATION_EXPORT void free_http_headers_decode(NSString *_Nonnull source,NSString * _Nullable * _Nullable target,NSDictionary * _Nullable * _Nullable headers);

@interface AFHTTPSessionManager (FreeHTTPHeaders)

- (RetriableOperation * _Nullable)GET:(NSString * _Nonnull)URLString
                   headers:(NSDictionary * _Nullable)headers
                parameters:(id _Nullable)parameters
                  progress:(void (^ _Nullable)(NSProgress * _Nonnull progress))downloadProgress
                   success:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                   failure:(void (^ _Nullable)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure
                retryAfter:(NSTimeInterval (^ _Nullable)(NSInteger currentRetryTime, NSError * _Nullable latestError))retryAfter;

- (RetriableOperation * _Nullable)POST:(NSString * _Nonnull)URLString
                    headers:(NSDictionary * _Nullable)headers
                 parameters:(id _Nullable)parameters
                   progress:(void (^ _Nullable)(NSProgress *_Nonnull progress))uploadProgress
                    success:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                    failure:(void (^ _Nullable)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure
                 retryAfter:(NSTimeInterval (^_Nullable)(NSInteger currentRetryTime, NSError *_Nullable latestError))retryAfter;

- (RetriableOperation * _Nullable)POST:(NSString * _Nonnull)URLString
                    headers:(NSDictionary * _Nullable)headers
                 parameters:(id _Nullable)parameters
  constructingBodyWithBlock:(void (^ _Nullable)(id<AFMultipartFormData> _Nullable formData))block
                   progress:(void (^ _Nullable)(NSProgress * _Nonnull progress))uploadProgress
                    success:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                    failure:(void (^ _Nullable)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure
                 retryAfter:(NSTimeInterval (^_Nullable)(NSInteger currentRetryTime, NSError * _Nullable latestError))retryAfter;

- (RetriableOperation * _Nullable)HEAD:(NSString * _Nonnull)URLString
                    headers:(NSDictionary * _Nullable)headers
                 parameters:(id _Nullable)parameters
                    success:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task))success
                    failure:(void (^ _Nullable)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure
                 retryAfter:(NSTimeInterval (^ _Nullable)(NSInteger currentRetryTime, NSError * _Nullable latestError))retryAfter;

- (RetriableOperation * _Nullable)PUT:(NSString * _Nonnull)URLString
                   headers:(NSDictionary * _Nullable)headers
                parameters:(id _Nullable)parameters
                   success:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                   failure:(void (^ _Nullable)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure
                retryAfter:(NSTimeInterval (^ _Nullable)(NSInteger currentRetryTime, NSError * _Nullable latestError))retryAfter;

- (RetriableOperation * _Nullable)PATCH:(NSString * _Nonnull)URLString
                     headers:(NSDictionary * _Nullable)headers
                  parameters:(id _Nullable)parameters
                     success:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                     failure:(void (^ _Nullable)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure
                  retryAfter:(NSTimeInterval (^ _Nullable)(NSInteger currentRetryTime, NSError * _Nullable latestError))retryAfter;

- (RetriableOperation * _Nullable)DELETE:(NSString * _Nonnull)URLString
                      headers:(NSDictionary * _Nullable)headers
                   parameters:(id _Nullable)parameters
                      success:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                      failure:(void (^ _Nullable)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure
                   retryAfter:(NSTimeInterval (^ _Nullable)(NSInteger currentRetryTime, NSError * _Nullable latestError))retryAfter;

@end

