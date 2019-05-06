
Pod::Spec.new do |s|
    
  s.name             = 'ZYAuth'
  s.version          = '0.1.8'
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
  
  s.subspec 'Protocol' do |ss|
      ss.source_files = 'ZYAuth/Classes/ZYAuthManager/Protocol/*'
  end
  
  
  s.subspec 'AuthSubManager' do |ss|
      
      ss.subspec 'WechatAuth' do |sss|
          sss.source_files = 'ZYAuth/Classes/ZYAuthManager/Auth/WechatAuth/*.{h,m}'
          sss.dependency 'WechatOpenSDK'     # 微信
      end
      
      ss.subspec 'TencenAuth' do |sss|
          sss.source_files = 'ZYAuth/Classes/ZYAuthManager/Auth/TencenAuth/*.{h,m}'
      end
      
      ss.subspec 'SinaAuth' do |sss|
          sss.source_files = 'ZYAuth/Classes/ZYAuthManager/Auth/SinaAuth/*.{h,m}'
          sss.dependency 'Weibo_SDK'         # 微博
      end
  end
  
  
  s.subspec 'AuthManager' do |ss|
      
    ss.source_files = 'ZYAuth/Classes/ZYAuthManager/Auth/*.{h,m}'
    
  end
  
  
  
  
end
