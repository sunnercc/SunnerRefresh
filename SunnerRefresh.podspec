#
#  Be sure to run `pod spec lint SunnerRefresh.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

# https://www.jianshu.com/p/32ba94d41861

Pod::Spec.new do |s|

    s.name         = "SunnerRefresh"
    s.version      = "0.0.1"
    s.summary      = "sunner refresh"
    s.homepage     = "https://github.com/sunnercc/SunnerRefresh"
    s.license      = "MIT"
    s.author             = { "sunner" => "sunner.cc@outlook.com" }
    s.platform     = :ios, "9.0"
    s.source       = { :git => "https://github.com/sunnercc/SunnerRefresh.git", :tag => "0.0.1" }
    s.source_files  = "SunnerRefresh", "SunnerRefresh/**/*.{h,m,swift}"
    s.framework  = "UIKit"
#    s.dependency "JSONKit", "~> 1.4"

end
