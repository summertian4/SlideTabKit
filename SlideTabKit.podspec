#
#  Be sure to run `pod spec lint LPDBPublicModule.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "SlideTabKit"
  s.version      = "0.1.1"
  s.summary      = "Simple and easy to use tools of slide tab / 简单易用的滑动标签栏工具"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.homepage     = "https://github.com/summertian4/SlideTabKit"
  s.source       = { :git => "https://github.com/summertian4/SlideTabKit.git", :tag => "#{s.version}" }
  s.source_files = "SlideTabKit/**/*"
  s.requires_arc = true
  s.platform     = :ios, "8.0"

  s.dependency   'SnapKit', '~> 3.2.0' # 依赖库
  s.dependency   'FrameKit', '~> 0.1.0' # 依赖库

  # User
  s.author             = { "小鱼周凌宇" => "coderfish@163.com" }
  s.social_media_url   = "http://zhoulingyu.com"

end