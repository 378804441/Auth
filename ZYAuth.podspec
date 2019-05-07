
Pod::Spec.new do |s|
    
  s.name             = 'ZYAuth'
  s.version          = '0.2.2.0'
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
                         'ZYAuth/Classes/ZYAuthManager/Auth/*.{h,m}']
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
 
end
