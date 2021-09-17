#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_payone.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_payone'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin.'
  s.description      = <<-DESC
A new Flutter plugin.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'
  s.vendored_libraries = 'src/*.a'
  s.vendored_frameworks ='src/*.framework'
  s.dependency 'PubNub', '4.12.0'
  s.xcconfig = { 'SWIFT_INCLUDE_PATHS' => '$(PODS_ROOT)/src $(PODS_TARGET_SRCROOT)/src' }
  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64','SWIFT_INCLUDE_PATHS' => '$(inherited) $(PROJECT_DIR)/src/','LIBRARY_SEARCH_PATHS' => '$(inherited) $(PROJECT_DIR)/src/' }
  s.swift_version = '5.0'
end
