

Pod::Spec.new do |s|
s.name         = "TFCrashSafeKit"
s.version      = "0.0.1"
s.ios.deployment_target = '8.0'
s.summary      = "A safekit for ios"
s.homepage     = "https://github.com/shmxybfq/TFCrashSafeKit"
s.license      = "MIT"
s.author             = { "ZTF" => "927141965@qq.com" }
s.social_media_url   = "https://www.jianshu.com/p/95c8d3e52ba4"
s.source       = { :git => "https://github.com/shmxybfq/TFCrashSafeKit.git", :tag => s.version }
s.source_files  = "TFCrashSafeKit/*.{h,m}"
s.requires_arc = true
end
