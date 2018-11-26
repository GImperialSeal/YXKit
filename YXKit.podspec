
Pod::Spec.new do |s|
  s.name             = 'YXKit'
  s.version          = '0.0.496'
  s.summary          = '常用类.'
  s.homepage         = 'https://github.com/GImperialSeal/YXKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '18637780521@163.com' => 'guyuxi@cashsoso.com' }
  s.source           = { :git => 'https://github.com/GImperialSeal/YXKit.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'YXKit/Classes/**/*'
  s.dependency 'YYKit'
  s.dependency 'BFKit'


  s.subspec 'Config' do |ss|
      ss.source_files = 'YXKit/Classes/Config/*'
      
  end

  s.subspec 'WKWebView' do |ss|
  ss.source_files = 'YXKit/Classes/WKWebView/*'
  end

  s.subspec 'Until' do |ss|
  ss.source_files = 'YXKit/Classes/Until/*'
  ss.dependency 'YXKit/WKWebView'
  ss.dependency 'YXKit/Config'
  end
  
  s.subspec 'QRCode' do |ss|
      ss.source_files = 'YXKit/Classes/QRCode/*'
  end

  s.subspec 'UMShare' do |ss|
  ss.source_files = 'YXKit/Classes/UMShare/*'
  ss.dependency  'UMCCommon'
  ss.dependency     'UMCShare/Social/SMS'
  ss.dependency     'UMCShare/Social/ReducedWeChat'
  ss.dependency     'UMCShare/Social/ReducedQQ'
  ss.dependency     'UMCShare/Social/ReducedSina'
  end

  s.subspec 'View' do |ss|
     ss.source_files = 'YXKit/Classes/View/*'
     ss.dependency 'YXKit/Until'
     ss.dependency  'Masonry'
   end


end
