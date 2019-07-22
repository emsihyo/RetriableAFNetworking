Pod::Spec.new do |spec|
    spec.name     = 'RetriableAFNetworking'
    spec.version  = '1.0.4'
    spec.license  = 'MIT'
    spec.summary  = 'Retriable AFNetworking'
    spec.homepage = 'https://github.com/retriable/RetriableAFNetworking'
    spec.author   = { 'retriable' => 'retriable@retriable.com' }
    spec.source   = { :git => 'https://github.com/retriable/RetriableAFNetworking.git',:tag => "#{spec.version}" }
    spec.description = 'Retriable AFNetworking.'
    spec.requires_arc = true
    spec.ios.deployment_target = '8.0'
    spec.watchos.deployment_target = '2.0'
    spec.tvos.deployment_target = '9.0'
    spec.osx.deployment_target = '10.9'
    spec.source_files = 'RetriableAFNetworking/*.{h,m}'
    spec.dependency 'Retriable'
    spec.dependency 'AFNetworking'
    spec.dependency 'JRSwizzle'
end
