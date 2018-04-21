[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://raw.githubusercontent.com/emsihyo/RetriableAFNetworking/master/LICENSE)
[![Build Status](http://img.shields.io/travis/emsihyo/RetriableAFNetworking/master.svg?style=flat)](https://travis-ci.org/emsihyo/RetriableAFNetworking)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/emsihyo/RetriableAFNetworking)
[![Pod Version](http://img.shields.io/cocoapods/v/RetriableAFNetworking.svg?style=flat)](http://cocoapods.org/pods/RetriableAFNetworking)
[![Pod Platform](http://img.shields.io/cocoapods/p/RetriableAFNetworking.svg?style=flat)](http://cocoapods.org/pods/RetriableAFNetworking)

# RetriableAFNetworking

Retriable AFNetworking

#### Cocoapods

Add the following to your project's Podfile:
```ruby
pod 'RetriableAFNetworking'
```

#### Carthage

Add the following to your project's Cartfile:
```ruby
github "emsihyo/RetriableAFNetworking"
```

#### Example

```objc
[sessionManager GET:@"https://api.github.com/repos/emsihyo/RetriableAFNetworking/readme" parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {

} failure:^(NSURLSessionDataTask *task, NSError *error) {

} retryAfter:^NSTimeInterval(NSInteger currentRetryTime, NSError *latestError) {
if(![latestError.domain isEqualToString:NSURLErrorDomain]) return 0;
switch (latestError.code) {
case NSURLErrorTimedOut:
case NSURLErrorNotConnectedToInternet:
case NSURLErrorNetworkConnectionLost: return 5;
default: return 0;
}
}];
```
