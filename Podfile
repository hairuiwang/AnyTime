# Uncomment the next line to define a global platform for your project
 platform :ios, '14.0'

target 'AnyTime' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for AnyTime
  pod 'AFNetworking', :git => 'https://github.com/crasowas/AFNetworking.git'
  pod 'SDWebImage'
  pod 'MJRefresh'
  pod 'Masonry'
  pod 'YYText'
  pod 'MBProgressHUD'
  pod 'MJExtension'
  pod 'IQKeyboardManager'
#  pod 'LookinServer'
  pod 'Reachability'
  pod 'FBSDKCoreKit'
  
  
  target 'AnyTimeTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'AnyTimeUITests' do
    # Pods for testing
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      deployment_target = config.build_settings['IPHONEOS_DEPLOYMENT_TARGET']
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0' if deployment_target && deployment_target.to_f < 14.0
    end
  end
end
