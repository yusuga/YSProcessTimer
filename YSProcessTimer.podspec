Pod::Spec.new do |s|
  s.name = 'YSProcessTimer'
  s.version = '0.0.9'
  s.summary = 'Process timer.'
  s.homepage = 'https://github.com/yusuga/YSProcessTimer'
  s.license = 'MIT'
  s.author = 'Yu Sugawara'
  s.source = { :git => 'https://github.com/yusuga/YSProcessTimer.git', :tag => s.version.to_s }
  s.platform = :ios, '6.0'
  s.ios.deployment_target = '6.0'
  s.source_files = 'Classes/YSProcessTimer/*.{h,m}'
  s.requires_arc = true  
end