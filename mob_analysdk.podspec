Pod::Spec.new do |s|
  s.name                  = 'mob_analysdk'
  s.version               = "1.1.1"
  s.summary               = 'mob.com 官方提供的统计SDK'
  s.license               = 'MIT'
  s.author                = { "mob" => "mobproducts@163.com" }

  s.homepage              = 'http://www.mob.com'
  s.source                = { :git => "https://github.com/MobClub/AnalySDK-for-iOS.git", :tag => s.version.to_s }
  s.platform              = :ios
  s.ios.deployment_target = "8.0"
  s.default_subspecs      = 'AnalySDK'
  s.dependency 'MOBFoundation'

  s.subspec 'AnalySDK' do |sp|
      sp.vendored_frameworks   = 'SDK/AnalySDK/AnalySDK.framework'
  end

end
