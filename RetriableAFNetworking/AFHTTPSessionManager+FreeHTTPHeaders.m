//
//  AFHTTPSessionManager+FreeHTTPHeaders.m
//  RetriableAFNetworking
//
//  Created by emsihyo on 2018/4/19.
//  Copyright © 2018年 emsihyo. All rights reserved.
//

#import "AFHTTPRequestSerializer+FreeHTTPHeaders.h"
#import "AFHTTPSessionManager+FreeHTTPHeaders.h"
#import "AFHTTPSessionManager+Retriable.h"

NSString *const free_http_headers_key = @"free-http-header-key";
NSString *const free_http_url_key = @"free-http-url-key";

static inline split_url(NSString **careless,NSString **query){
    static NSRegularExpression *regex;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regex=[NSRegularExpression regularExpressionWithPattern:@"^(?<careless>.?)(\\?.?)$" options:0 error:nil];
    });
    NSTextCheckingResult *result=[regex firstMatchInString:url options:0 range:NSMakeRange(0, url.length)];
    if(result) return [[url substringWithRange:NSMakeRange(result.range.location+1, result.range.length)] mutableCopy];
    return nil;
}

void free_http_headers_encode(NSString *source,NSString **target,NSDictionary *headers){
    *target=source;
    NSURLComponents *components=[NSURLComponents componentsWithString:source];
    if (!components) return;
    if (![headers isKindOfClass:NSDictionary.class]) return;
    NSString *value=[[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:headers options:0 error:nil] encoding:NSUTF8StringEncoding];
    if(value.length==0) return;
    NSMutableString *query=get_query_from_url(source);
    if(!query) query=[NSMutableString stringWithFormat:@"%@=%@&%@=%@",free_http_url_key,source,free_http_headers_key,value];
    else [query insertString:[NSString stringWithFormat:@"%@=%@&%@=%@&",free_http_url_key,source,free_http_headers_key,value] atIndex:0];
    components.query=query;
    *target=components.URL.absoluteString;
}

void free_http_headers_decode(NSString *source,NSString **target,NSDictionary **headers){
    *target=source;
    NSString *query=get_query_from_url(source);
    if (!query) return;
    static NSRegularExpression *regex;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regex=[NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@"^%@\\=(?<url>.*?)\\&%@\\=(?<value>.*?)(\\&|$)",free_http_url_key,free_http_headers_key] options:0 error:nil];
    });
    NSTextCheckingResult *result=[regex firstMatchInString:query options:0 range:NSMakeRange(0, query.length)];
    if (!result) return;
    *headers=[NSJSONSerialization JSONObjectWithData:[[[query substringWithRange:[result rangeAtIndex:2]]  stringByRemovingPercentEncoding] dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    *target=[query substringWithRange:[result rangeAtIndex:1]];
}

@implementation AFHTTPSessionManager (FreeHTTPHeaders)
- (RetriableOperation*)GET:(NSString *)URLString headers:(NSDictionary*)headers parameters:(id)parameters progress:(void (^)(NSProgress *))downloadProgress success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure retryAfter:(NSTimeInterval (^)(NSInteger, NSError *))retryAfter{
    NSString *urlWithHeaders;
    free_http_headers_encode(URLString, &urlWithHeaders, headers);
    return [self GET:urlWithHeaders parameters:parameters progress:downloadProgress success:success failure:failure retryAfter:retryAfter];
}

- (RetriableOperation*)POST:(NSString *)URLString headers:(NSDictionary*)headers parameters:(id)parameters progress:(void (^)(NSProgress *))uploadProgress success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure retryAfter:(NSTimeInterval (^)(NSInteger, NSError *))retryAfter{
    NSString *urlWithHeaders;
    free_http_headers_encode(URLString, &urlWithHeaders, headers);
    return [self POST:urlWithHeaders parameters:parameters progress:uploadProgress success:success failure:failure retryAfter:retryAfter];
}

- (RetriableOperation*)POST:(NSString *)URLString headers:(NSDictionary*)headers parameters:(id)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block progress:(void (^)(NSProgress *))uploadProgress success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure retryAfter:(NSTimeInterval (^)(NSInteger, NSError *))retryAfter{
    NSString *urlWithHeaders;
    free_http_headers_encode(URLString, &urlWithHeaders, headers);
    return [self POST:urlWithHeaders parameters:parameters constructingBodyWithBlock:block progress:uploadProgress success:success failure:failure retryAfter:retryAfter];
}

- (RetriableOperation*)HEAD:(NSString *)URLString headers:(NSDictionary*)headers parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure retryAfter:(NSTimeInterval (^)(NSInteger, NSError *))retryAfter{
    NSString *urlWithHeaders;
    free_http_headers_encode(URLString, &urlWithHeaders, headers);
    return [self HEAD:urlWithHeaders parameters:parameters success:success failure:failure retryAfter:retryAfter];
}

- (RetriableOperation*)PUT:(NSString *)URLString headers:(NSDictionary*)headers parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure retryAfter:(NSTimeInterval (^)(NSInteger, NSError *))retryAfter{
    NSString *urlWithHeaders;
    free_http_headers_encode(URLString, &urlWithHeaders, headers);
    return [self PUT:urlWithHeaders parameters:parameters success:success failure:failure retryAfter:retryAfter];
}

- (RetriableOperation*)PATCH:(NSString *)URLString headers:(NSDictionary*)headers parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure retryAfter:(NSTimeInterval (^)(NSInteger, NSError *))retryAfter{
    NSString *urlWithHeaders;
    free_http_headers_encode(URLString, &urlWithHeaders, headers);
    return [self PATCH:urlWithHeaders parameters:parameters success:success failure:failure retryAfter:retryAfter];
}

- (RetriableOperation*)DELETE:(NSString *)URLString headers:(NSDictionary*)headers parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure retryAfter:(NSTimeInterval (^)(NSInteger, NSError *))retryAfter{
    NSString *urlWithHeaders;
    free_http_headers_encode(URLString, &urlWithHeaders, headers);
    return [self DELETE:urlWithHeaders parameters:parameters success:success failure:failure retryAfter:retryAfter];
}

@end
