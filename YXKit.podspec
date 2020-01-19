
Pod::Spec.new do |s|
  s.name             = 'YXKit'
  s.version          = '0.0.70'
  s.summary          = '常用类.'
  s.homepage         = 'https://github.com/GImperialSeal/YXKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '18637780521@163.com' => 'guyuxi@cashsoso.com' }
  s.source           = { :git => 'https://github.com/GImperialSeal/YXKit.git', :tag => s.version}
  # 工程依赖系统版本
  s.ios.deployment_target = '8.0'
  s.source_files = 'YXKit/Classes/**/*.{h,m}'
  s.resources = ['YXKit/Classes/Resources/YXResources.bundle']
  s.dependency 'YYKit'
#  s.dependency 'BFKit'
  s.dependency 'ReactiveObjC'
#  s.dependency 'UITableView+FDTemplateLayoutCell'
  s.dependency  'Masonry'
  s.dependency  'FCUUID'
  s.dependency 'YTKNetwork'
  s.dependency 'LLDebugTool'

#  s.dependency 'SocketRocket'
  
  #s.subspec 'im_ios' do |ss|
#      ss.static_framework  =  true

#    ss.source_files = 'YXKit/im_ios/*.{h,m,mm}'
#
#      # 系统动态库(多个)
#      ss.frameworks = 'SystemConfiguration','CoreTelephony','AVFoundation','AudioToolbox','CoreLocation'
#
#      # 系统类库(多个) 注意:系统类库不需要写全名 去掉开头的lib
#      ss.libraries = 'z','sqlite3.0','resolv.9','c++.1'
#
#      # 第三方非开源framework(多个)
##      ss.vendored_frameworks   = ['YXKit/im_ios/AliyunNlsSdk.framework','YXKit/im_ios/iflyMSC.framework','YXKit/im_ios/USCModule.framework']
#      ss.vendored_frameworks   = 'YXKit/im_ios/*.framework'
#
#      ss.vendored_libraries = 'YXKit/im_ios/*.{a}'
#
#      # 公开头文件 打包只公开特定的头文件
#      ss.public_header_files   = 'YXKit/im_ios/*.{h}'
      
      #"CFMobAdSDK/*
      #"CFMobAdSDK/*.{h,m}"
      #"CFMobAdSDK/**/*.h"
      #“” 表示匹配所有文件
      #“.{h,m}” 表示匹配所有以.h和.m结尾的文件
      #“**” 表示匹配所有子目录
#
#      # 资源文件 .png/.bundle等(多个)
#        # 'SOCR/Assets/*.png',
##      s.resource_bundles = {
##         'SOCR' =>[
##         'SOCR/Assets/com.baidu.idl.face.faceSDK.bundle',
##         'SOCR/Assets/com.baidu.idl.face.model.bundle',
##         'SOCR/Assets/CWResource.bundle'
##         ]
##         }
##
#
#     # 是否是静态库 这个地方很重要 假如不写这句打出来的包 就是动态库 不能使用 一运行会报错 image not found
#       # s.static_framework  =  true
#
#
#  end
#
  
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
