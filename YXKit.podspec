
Pod::Spec.new do |s|
  s.name             = 'YXKit'
  s.version          = '0.0.6'
  s.summary          = '常用类.'
  s.homepage         = 'https://github.com/GImperialSeal/YXKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '18637780521@163.com' => 'guyuxi@cashsoso.com' }
  s.source           = { :git => 'https://github.com/GImperialSeal/YXKit.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'YXKit/Classes/**/*.{h,m}'
  s.resources = ['YXKit/Classes/Resources/YXResources.bundle']
  s.dependency 'YYKit'
  s.dependency 'BFKit'
  s.dependency 'ReactiveObjC'
  s.dependency 'UITableView+FDTemplateLayoutCell'
  s.dependency  'Masonry'
  s.dependency  'FCUUID'
  s.dependency 'YTKNetwork'
  s.dependency 'SocketRocket'


  
  
end


#s.subspec 'Config' do |ss|
#ss.source_files = 'YXKit/Classes/Config/*'
#end
#s.subspec 'Setting' do |ss|
#   ss.source_files = 'YXKit/Classes/Setting/*'
#   ss.dependency 'YXKit/Until'
#end

#s.subspec 'AppDelegateManager' do |ss|
#   ss.source_files = 'YXKit/Classes/AppDelegateManager/*'
#   ss.dependency 'YXKit/Config'
#end

#s.subspec 'WKWebView' do |ss|
#   ss.source_files = 'YXKit/Classes/WKWebView/*'
#end

#s.subspec 'Until' do |ss|
#   ss.source_files = 'YXKit/Classes/Until/*'
#   ss.dependency 'YXKit/WKWebView'
#   ss.dependency 'YXKit/Config'
#end

#s.subspec 'QRCode' do |ss|
# ss.source_files = 'YXKit/Classes/QRCode/*'
#end

#s.subspec 'Network' do |ss|
# ss.source_files = 'YXKit/Classes/Network/*'
# ss.dependency 'YTKNetwork'
#end


#s.subspec 'View' do |ss|
#  ss.source_files = 'YXKit/Classes/View/*'
# ss.dependency 'YXKit/Until'
#end
