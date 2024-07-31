#
# Be sure to run `pod lib lint DomobSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DomobSDK'
  s.version          = '3.4.3'
  s.summary          = '多盟广告SDK'
  
  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  
  s.description      = <<-DESC
  TODO: Add long description of the pod here.
  DESC
  
  s.homepage         = 'https://github.com/dmdsp/DomobAdSDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'shilin.liu' => 'shilin.liu@domob.cn' }
  s.source           = { :git => 'https://github.com/dmdsp/DomobAdSDK.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  
  s.ios.deployment_target = '10.0'
  
# s.source_files = 'DomobSDK/Classes/**/*'
  
  s.subspec 'DMAdSDK' do |dmadsdk|
    dmadsdk.frameworks = 'AdSupport', 'AppTrackingTransparency', 'CoreLocation', 'CoreMotion', 'CoreTelephony'
    dmadsdk.dependency 'Protobuf', '~> 3.27'
    dmadsdk.dependency 'Masonry'
    dmadsdk.dependency 'SDWebImage'
    dmadsdk.vendored_frameworks = 'DomobSDK/Classes/DMAdSDK.xcframework'
    
    dmadsdk.resource_bundles = {
        'DMAdSDK_Bundle' => ['DomobSDK/Classes/DMAdSDK_Bundle.bundle/**/*']
    }
  end
  
  s.subspec 'DomobSDKAdapter' do |domobsdkadapter|
    # 添加 DMengSDKAdapter 的其他配置信息
    domobsdkadapter.dependency 'DomobSDK/DMAdSDK'
    domobsdkadapter.vendored_frameworks = 'DomobSDK/Classes/DomobSDKAdapter.xcframework'
    
  end
  
  s.subspec 'GMAdSDKAdapter' do |gmadsdkadapter|
    # 添加 GMAdSDKAdapter 的配置信息
    gmadsdkadapter.dependency 'Ads-CN-Beta', '6.2.0.0'
    gmadsdkadapter.dependency 'Ads-CN-Beta/CSJMediation'
    gmadsdkadapter.dependency 'GMKsAdapter-Beta', '~> 3.3.64.0.0'
    gmadsdkadapter.dependency 'KSAdSDK', '~> 3.3.61'
    gmadsdkadapter.dependency 'DomobSDK/DomobSDKAdapter'
    gmadsdkadapter.ios.deployment_target = '12.0'

    gmadsdkadapter.vendored_frameworks = 'DomobSDK/Classes/GMAdSDKAdapter.xcframework'
    
  end
  
  s.subspec 'KSAdSDKAdapter' do |ksadsdkadapter|
    # 添加 DMAdSDKAdapter 的配置信息
    ksadsdkadapter.dependency 'KSAdSDK', '~> 3.3.61'
    ksadsdkadapter.dependency 'DomobSDK/DomobSDKAdapter'
    ksadsdkadapter.ios.deployment_target = '12.0'

    ksadsdkadapter.vendored_frameworks = 'DomobSDK/Classes/KSAdSDKAdapter.xcframework'
    
  end
  
  
  s.static_framework = true
  s.default_subspec = 'DMAdSDK' # 将DMAdSDK设为默认子模块
  
end
