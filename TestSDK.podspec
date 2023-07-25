Pod::Spec.new do |spec|
spec.name = "TestSDK"
spec.version = "1.0.4"
spec.summary = "My Library to learn"
spec.description = "It is a library only for learning purpose"
spec.homepage = "https://edoctor.io/"
spec.license = { :type => "MIT", :file => "LICENSE" }
spec.author = { "bui dinh manh" => "buidinhmanh14799@gmail.com" }
spec.platform = :ios, "13.0"
spec.swift_version = '5.0'
spec.source = { :git => "https://github.com/buidinhmanh14799/testSDK.git", :tag => '1.0.4' }
spec.source_files = "Sources/TestEdoctorSDK/*.{swift}"
end
