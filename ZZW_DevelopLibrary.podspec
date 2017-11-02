

Pod::Spec.new do |s|
  s.name             = 'ZZW_DevelopLibrary'
  s.version          = '0.1.4'
  s.summary          = '周泽苹果开发组件库'

  s.description      = <<-DESC
    包含了启动页广告功能
                       DESC

  s.homepage         = 'https://github.com/zhouzewen/ZZW_DevelopLibrary'
  #开源协议
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '周泽文' => 'a595429717@163.com' }
  s.source           = { :git => "https://github.com/zhouzewen/ZZW_DevelopLibrary.git", :tag => "#{s.version}" }

  s.ios.deployment_target = '8.0'
#s.source_files = 'ZZW_DevelopLibrary/**/*'
  s.ios.vendored_frameworks = "ZZW_LaunchAD.framework"




  # s.resource_bundles = {
  #   'CivetWebRTCKit' => ['CivetWebRTCKit/Assets/*.png']
  # }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'GLKit', 'VideoToolbox'
  # s.dependency 'AFNetworking', '~> 2.3'
end
