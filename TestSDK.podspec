Pod::Spec.new do |spec|
spec.name = "MyLibrary"
spec.version = "0.0.1"
spec.summary = "My Library to learn"
spec.description = "It is a library only for learning purpose"
spec.homepage = "https://github.com/sanjeev/MyLibrary"
spec.license = { :type => "MIT", :file => "LICENSE" }
spec.author = { "Sanjeev Gautam" => "sanjeev.gautam@xyz.com" }
spec.platform = :ios, "13.0"
spec.swift_version = '5.0'
spec.source = { :git => "https://github.com/sanjeev/MyLibrary.git", :tag => '0.0.1' }
spec.source_files = "MyLibrary/MyLibrary/**/*.{swift}"
end
