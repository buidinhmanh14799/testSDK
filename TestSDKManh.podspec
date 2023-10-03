Pod::Spec.new do |spec|
spec.name = "TestSDKManh"
spec.version = "1.0.1"
spec.summary = "My Library to learn"
spec.description = "It is a library only for learning purpose"
spec.homepage = "https://edoctor.io/"
spec.license = { :type => "MIT", :file => "LICENSE" }
spec.author = { "bui dinh manh" => "buidinhmanh14799@gmail.com" }
spec.platform = :ios, "14.0"
spec.swift_version = '5.0'
spec.dependencies = {
'SendBirdCalls' => ['~> 1.10.11'],
}
spec.source = { :git => "https://github.com/buidinhmanh14799/testSDK.git", :branch => 'main' }
spec.source_files = "Sources/TestEdoctorSDK/*.{swift}", "Sources/TestEdoctorSDK/*/*.{swift}", "Sources/TestEdoctorSDK/*/*/*.{swift}"
end
