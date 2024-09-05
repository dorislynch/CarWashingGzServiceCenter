
Pod::Spec.new do |s|
  s.name         = "RNCarWashingGzServiceCenter"
  s.version      = "1.0.1"
  s.summary      = "RNCarWashingGzServiceCenter"
  s.description  = <<-DESC
                  RNCarWashingGzServiceCenter
                   DESC
  s.homepage     = "https://github.com/dorislynch/CarWashingGzServiceCenter"
  s.license      = "MIT"
                   # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "author" => "author@domain.cn" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/dorislynch/CarWashingGzServiceCenter.git", :tag => "master" }
  s.source_files  = "ios/**/*.{h,m}"
  s.requires_arc = true
                 
                 
  s.dependency 'React'
  s.dependency 'CocoaSecurity'
  s.dependency 'GCDWebServer'
  #s.dependency "others"

end

  