#
# Be sure to run `pod lib lint TeneasyChatSDKUI_iOS.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TeneasyChatSDKUI_iOS'
  s.version          = '0.1.0'
  s.summary          = 'A short description of TeneasyChatSDKUI_iOS.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/7938813/TeneasyChatSDKUI_iOS'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '7938813' => 'tianxuefeng2010@gmail.com' }
  s.source           = { :git => 'https://github.com/7938813/TeneasyChatSDKUI_iOS.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'TeneasyChatSDKUI_iOS/Classes/**/*'
  
   s.resource_bundles = {
     'TeneasyChatSDKUI_iOS' => ['TeneasyChatSDKUI_iOS/Assets/**/*','TeneasyChatSDKUI_iOS/Assets/*.png', 'TeneasyChatSDKUI_iOS/Assets/emoji/*.png', 'TeneasyChatSDKUI_iOS/Assets/emoji/*.gif']
   }

  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'UIKit'#, 'MapKit'
   s.dependency 'TeneasyChatSDK_iOS', '~> 0.1.0'
   s.dependency 'SnapKit', '~> 5.0.1'
   s.dependency 'IQKeyboardManagerSwift', '~> 6.5.9'
end
