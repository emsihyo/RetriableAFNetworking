//
//  RetriableAFNetworkingTests_iOS.m
//  RetriableAFNetworkingTests iOS
//
//  Created by retriable on 2018/4/24.
//  Copyright © 2018年 retriable. All rights reserved.
//

@import RetriableAFNetworking;

#import <XCTest/XCTest.h>

@interface RetriableAFNetworkingTests_iOS : XCTestCase

@end

@implementation RetriableAFNetworkingTests_iOS

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    printf("\n\ntestExample start\n\n");
    NSArray *us1=@[@"",@" ",@"/",@"//",@"https://www.google.com/",@"free-http-header-key"];
    NSArray *us2=@[@"",@" ",@"?",@"??",@"???"];
    NSArray *us3=@[@"",@" ",@"id",@"id=",@"id=1",@"id=1&",@"id=1&type",@"id=1&type=",@"id=1&type=1"];
    NSArray *allHeaders=@[NSNull.null,@{},@{@"x-retriable-key":@"`1234567890-=\\][';/.~!@#$%^&*()_+|}{\":?><",@"free-http-url-key":@"free-http-header-key",@"free-http-header-key":@"free-http-header-key"}];
    for (NSString *u1 in us1){
        for (NSString *u2 in us2){
            for (NSString *u3 in us3){
                NSString *url=[NSString stringWithFormat:@"%@%@%@",u1,u2,u3];
                for (id  headers in allHeaders){
                    XCTAssertTrue([self startWithURL:url headers:headers==NSNull.null?nil:headers],@"failed");
                }
            }
        }
    }
    printf("\n\ntestExample finish\n\n");
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (BOOL)startWithURL:(NSString *)originalURL headers:(NSDictionary*)originalHeaders{
    NSString *encodedURL,*decodedURL;
    NSDictionary *decodedHeaders;
    free_http_headers_encode(originalURL, &encodedURL, originalHeaders);
    free_http_headers_decode(encodedURL, &decodedURL, &decodedHeaders);
    if (![originalURL isEqualToString:decodedURL]||(originalHeaders&&![originalHeaders isEqualToDictionary:decodedHeaders])) {
        printf("\noriginal     url:%s\
                \ndecoded      url:%s\
                \nencoded      url:%s\
                \noriginal headers:%s\
                \ndecoded  headers:%s\
                \n",originalURL.UTF8String,decodedURL.UTF8String,encodedURL.UTF8String,[[originalHeaders description] stringByReplacingOccurrencesOfString:@"\n" withString:@" "].UTF8String,[[decodedHeaders description] stringByReplacingOccurrencesOfString:@"\n" withString:@" "].UTF8String);
        return NO;
    }
    return YES;
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
