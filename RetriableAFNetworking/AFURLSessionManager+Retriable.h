//
//  AFURLSessionManager+Retriable.h
//  RetriableAFNetworking
//
//  Created by emsihyo on 2018/5/2.
//  Copyright © 2018年 emsihyo. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <Retriable/Retriable.h>

@interface AFURLSessionManager (Retriable)

@property (readonly) NSOperationQueue * _Nonnull retriable_operationQueue;

- (RetriableOperation * _Nullable)dataTaskWithRequest:(NSURLRequest * _Nonnull)request
                             uploadProgress:(void (^_Nullable)(NSProgress * _Nullable uploadProgress))uploadProgressBlock
                           downloadProgress:(void (^_Nullable)(NSProgress * _Nullable downloadProgress))downloadProgressBlock
                          completionHandler:(void (^_Nullable)(NSURLResponse * _Nullable response, id _Nullable responseObject,  NSError * _Nullable error))completionHandler
                                 retryAfter:(NSTimeInterval(^ _Nullable)(NSInteger currentRetryTime,NSError * _Nullable latestError))retryAfter;

- (RetriableOperation * _Nullable)uploadTaskWithRequest:(NSURLRequest * _Nonnull)request
                                         fromFile:(NSURL * _Nonnull)fileURL
                                         progress:(void (^_Nullable)(NSProgress * _Nullable uploadProgress))uploadProgressBlock
                                completionHandler:(void (^_Nullable)(NSURLResponse * _Nullable response, id _Nullable responseObject, NSError  * _Nullable error))completionHandler
                                       retryAfter:(NSTimeInterval(^ _Nullable)(NSInteger currentRetryTime,NSError * _Nullable latestError))retryAfter;

- (RetriableOperation * _Nullable)uploadTaskWithRequest:(NSURLRequest * _Nonnull)request
                                         fromData:(NSData * _Nonnull)bodyData
                                         progress:(void (^_Nullable)(NSProgress * _Nullable uploadProgress))uploadProgressBlock
                                completionHandler:(void (^_Nullable)(NSURLResponse * _Nullable response, id _Nullable responseObject, NSError * _Nullable error))completionHandler
                                       retryAfter:(NSTimeInterval(^ _Nullable)(NSInteger currentRetryTime,NSError * _Nullable latestError))retryAfter;

- (RetriableOperation * _Nullable)uploadTaskWithStreamedRequest:(NSURLRequest * _Nonnull)request
                                                 progress:(void (^ _Nullable)(NSProgress * _Nullable uploadProgress))uploadProgressBlock
                                        completionHandler:(void (^ _Nullable)(NSURLResponse * _Nullable response, id _Nullable responseObject, NSError * _Nullable error))completionHandler
                                               retryAfter:(NSTimeInterval(^ _Nullable)(NSInteger currentRetryTime,NSError * _Nullable latestError))retryAfter;

- (RetriableOperation * _Nullable)downloadTaskWithRequest:(NSURLRequest * _Nonnull)request
                                             progress:(void (^_Nullable)(NSProgress * _Nullable downloadProgress))downloadProgressBlock
                                          destination:(NSURL * _Nullable (^_Nullable)(NSURL * _Nullable targetPath, NSURLResponse * _Nullable response))destination
                                    completionHandler:(void (^_Nullable)(NSURLResponse * _Nullable response, NSURL * _Nullable filePath, NSError * _Nullable error))completionHandler
                                           retryAfter:(NSTimeInterval(^ _Nullable)(NSInteger currentRetryTime,NSError * _Nullable latestError))retryAfter;

- (RetriableOperation * _Nullable)downloadTaskWithResumeData:(NSData * _Nonnull )resumeData
                                                progress:(void (^_Nullable)(NSProgress * _Nullable downloadProgress))downloadProgressBlock
                                             destination:(NSURL * _Nullable (^_Nullable)(NSURL * _Nullable targetPath, NSURLResponse * _Nullable response))destination
                                       completionHandler:(void (^_Nullable)(NSURLResponse * _Nullable response, NSURL * _Nullable filePath, NSError * _Nullable error))completionHandler
                                              retryAfter:(NSTimeInterval(^ _Nullable)(NSInteger currentRetryTime,NSError * _Nullable latestError))retryAfter;
@end
