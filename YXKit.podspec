
Pod::Spec.new do |s|
  s.name             = 'YXKit'
  s.version          = '0.1.0'
  s.summary          = 'A short description of YXKit.'
  s.homepage         = 'https://github.com/18637780521@163.com/YXKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '18637780521@163.com' => 'guyuxi@cashsoso.com' }
  s.source           = { :git => 'https://github.com/18637780521@163.com/YXKit.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'

  s.source_files = 'YXKit/Classes/**/*'
  
  s.subspec 'Config' do |ss|
      ss.source_files = 'Classes/Config/*'
      ss.dependency 'YYKit'
  end
end
