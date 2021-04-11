# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Top3' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
      end
    end
  end

  # Pods for Top3
  pod 'Firebase/Auth'
  pod 'Firebase/Analytics'
  pod 'Firebase/Firestore'
  pod 'FirebaseFirestoreSwift'

  pod 'GoogleSignIn'
  pod 'SnapKit', '~> 5.0.0'

  target 'Top3Tests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Top3UITests' do
    # Pods for testing
  end

end
