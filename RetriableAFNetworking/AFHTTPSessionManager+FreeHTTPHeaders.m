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

NSString *const free_http_headers_header_key = @"oo-http-header-key";

void free_http_headers_encode(NSString *source,NSString **target,NSDictionary *headers){
    *target=source;
    NSURLComponents *components=[NSURLComponents componentsWithString:source];
    if (!components) return;
    if (![headers isKindOfClass:NSDictionary.class]) return;
    NSData *data=[NSJSONSerialization dataWithJSONObject:headers options:0 error:nil];
    if(data.length==0) return;
    NSString *value=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    if(value.length==0) return;
    NSMutableString *query=[components.query mutableCopy];
    if(!query) query=[NSMutableString stringWithFormat:@"%@=%@",free_http_headers_header_key,value];
    else [query insertString:[NSString stringWithFormat:@"%@=%@&",free_http_headers_header_key,value] atIndex:0];
    components.query=query;
    *target=components.URL.absoluteString;
}

void free_http_headers_decode(NSString *source,NSString **target,NSDictionary **headers){
    *target=source;
    NSURLComponents *components=[NSURLComponents componentsWithString:source];
    if (!components) return;
    NSMutableString *query=[components.percentEncodedQuery mutableCopy];
    NSRegularExpression *regex=[NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@"(?<=(\\&|\\?|^))%@\\=(?<value>.*?)(\\&|$)",free_http_headers_header_key] options:0 error:nil];
    NSTextCheckingResult *result=[regex firstMatchInString:query options:0 range:NSMakeRange(0, query.length)];
    if (!result) return;
    *headers=[NSJSONSerialization JSONObjectWithData:[[[[[query substringWithRange:[result rangeAtIndex:2]] componentsSeparatedByString:@"="] lastObject]  stringByRemovingPercentEncoding] dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    [query deleteCharactersInRange:[result rangeAtIndex:0]];
    components.query=query;
    *target=components.URL.absoluteString;
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
