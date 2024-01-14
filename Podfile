# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

platform :ios, '15.4'

post_install do |installer|
  installer.pods_project.targets.each do |target|
   target.build_configurations.each do |config|
    config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.4'
   end
  end
 end

target 'GH Repo Search' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for GH Repo Search
  pod 'RealmSwift'

end
