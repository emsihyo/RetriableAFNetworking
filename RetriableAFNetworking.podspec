Pod::Spec.new do |spec|
    spec.name     = 'RetriableAFNetworking'
    spec.version  = '1.0.0'
    spec.license  = 'MIT'
    spec.summary  = 'Retriable AFNetworking'
    spec.homepage = 'https://github.com/emsihyo/RetriableAFNetworking'
    spec.author   = { 'emsihyo' => 'emsihyo@gmail.com' }
    spec.source   = { :git => 'https://github.com/emsihyo/RetriableAFNetworking.git',:tag => "#{spec.version}" }
    spec.description = 'Retriable AFNetworking.'
    spec.requires_arc = true
    spec.platform = :ios
    spec.ios.deployment_target = '8.0'
    spec.source_files = 'RetriableAFNetworking/*.{h,m}'
    spec.dependency 'Retriable'
    spec.dependency 'AFNetworking'
end
