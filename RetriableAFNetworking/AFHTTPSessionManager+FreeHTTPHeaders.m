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

static void split_url(NSString *url,NSString **careless,NSMutableString **query){
    static NSRegularExpression *regex;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regex=[NSRegularExpression regularExpressionWithPattern:@"^([^\\?]*$)|((.*\\?)(.*)$)" options:0 error:nil];
    });
    NSTextCheckingResult *result=[regex firstMatchInString:url options:0 range:NSMakeRange(0, url.length)];
    NSRange range=[result rangeAtIndex:1];
    if(range.length>0){
        *careless=[url substringWithRange:range];
        return;
    }
    range=[result rangeAtIndex:3];
    if(range.length>0) *careless=[url substringWithRange:range];
    range=[result rangeAtIndex:4];
    if(range.length>0) *query=[[url substringWithRange:range] mutableCopy];
}

void free_http_headers_encode(NSString *source,NSString **target,NSDictionary *headers){
    *target=source;
    if (source.length==0) return;
    if (![headers isKindOfClass:NSDictionary.class]) return;
    if (headers.count==0) return;
    NSString *value=[[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:headers options:0 error:nil] encoding:NSUTF8StringEncoding];
    if(value.length==0) return;
    NSString *careless;
    NSMutableString *query;
    split_url(source, &careless, &query);
    static NSMutableCharacterSet *set;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        set=[[NSCharacterSet URLQueryAllowedCharacterSet]mutableCopy];
        [set removeCharactersInString:@"?&"];
    });
    NSString *subQuery=[NSString stringWithFormat:@"%@=%@&%@=%@",free_http_url_key,[source stringByAddingPercentEncodingWithAllowedCharacters:set],free_http_headers_key,[value stringByAddingPercentEncodingWithAllowedCharacters:set]];
    if(!query) query=[[NSString stringWithFormat:@"?%@",subQuery] mutableCopy];
    else [query insertString:[NSString stringWithFormat:@"?%@&",subQuery] atIndex:0];
    *target=[[careless stringByReplacingOccurrencesOfString:@"?" withString:@""] stringByAppendingString:query];
}

void free_http_headers_decode(NSString *source,NSString **target,NSDictionary **headers){
    if (source.length==0) return;
    *target=source;
    NSString *careless;
    NSMutableString *query;
    split_url(source, &careless, &query);
    if (!careless||!query) return;
    static NSRegularExpression *regex;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regex=[NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@"^%@\\=(.+?)\\&%@\\=(.+?)(\\&|$)",free_http_url_key,free_http_headers_key] options:0 error:nil];
    });
    NSTextCheckingResult *result=[regex firstMatchInString:query options:0 range:NSMakeRange(0, query.length)];
    NSRange range=[result rangeAtIndex:1];
    if(range.length>0){
        *target=[[query substringWithRange:range] stringByRemovingPercentEncoding];
    }
    range=[result  rangeAtIndex:2];
    if (range.length>0){
        *headers=[NSJSONSerialization JSONObjectWithData:[[[query substringWithRange:range]  stringByRemovingPercentEncoding] dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    }
    return;
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
