
Pod::Spec.new do |s|
    
  s.name             = 'ZYAuth'
  s.version          = '0.2.2.6'
  s.summary          = 'A short description of ZYAuth.'
  s.description      = <<-DESC
                       TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/378804441/Auth'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'DW' => '378804441@qq.com' }
  s.source           = { :git => 'https://github.com/378804441/Auth.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.static_framework = true
  
  ####### 核心模块 ######
  s.subspec 'AuthCore' do |ss|
      ss.source_files = ['ZYAuth/Classes/ZYAuthManager/Protocol/*.{h,m}',
                         'ZYAuth/Classes/ZYAuthManager/Auth/*.{h,m}',
                         'ZYAuth/Classes/ZYAuthManager/ThreadSafety/*.{h,m}']
      ss.resource = 'ZYAuth/Classes/ZYAuthManager/Config/ZYSDKConfig.bundle'
  end
  
  ####### 微信 ######
  s.subspec 'WechatAuth' do |ss|
      ss.source_files = 'ZYAuth/Classes/ZYAuthManager/Auth/WechatAuth/*.{h,m}'
      ss.dependency 'WechatOpenSDK'
  end
  
  ####### 腾讯 ######
  s.subspec 'TencenAuth' do |ss|
      ss.subspec 'TencenSDK' do |sss|
          sss.source_files = 'ZYAuth/Classes/ZYAuthManager/Auth/TencenAuth/iOS_OpenSDK_V3.2.0_lite/**/*'
      end
      ss.source_files = 'ZYAuth/Classes/ZYAuthManager/Auth/TencenAuth/*.{h,m}'
  end
  
  ####### 微博 #######
  s.subspec 'SinaAuth' do |ss|
      ss.source_files = 'ZYAuth/Classes/ZYAuthManager/Auth/SinaAuth/*.{h,m}'
      ss.dependency 'Weibo_SDK'
  end
  
  ####### google #######
  s.subspec 'GoogleAuth' do |ss|
      ss.source_files = 'ZYAuth/Classes/ZYAuthManager/Auth/GoogleAuth/*.{h,m}'
      ss.dependency 'GoogleSignIn'
  end
  
  ####### facebook #######
  s.subspec 'FacebookAuth' do |ss|
      ss.source_files = 'ZYAuth/Classes/ZYAuthManager/Auth/FacebookAuth/*.{h,m}'
      ss.dependency 'FBSDKLoginKit'
  end

  ####### twitter #######
  s.subspec 'TwitterAuth' do |ss|
      ss.source_files = 'ZYAuth/Classes/ZYAuthManager/Auth/TwitterAuth/*.{h,m}'
      ss.dependency 'TwitterKit'
  end

end
