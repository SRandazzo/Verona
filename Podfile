# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Verona' do
  use_frameworks!

  target 'VeronaTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'FBSnapshotTestCase/SwiftSupport', :git => 'https://github.com/facebook/ios-snapshot-test-case.git', :commit => 'da629211c17a4c507e2e866e8a19ed3122af770b'
  end

end

target 'VeronaApp' do
  use_frameworks!
  # Pods for VeronaApp
  pod 'Verona', :path => "./"
end

post_install do |installer|
   installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
