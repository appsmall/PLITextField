#
# Be sure to run `pod lib lint PLITextField.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PLITextField'
  s.version          = '0.1.0'
  s.summary          = 'This library is used to add image, text field, country code picker in one view.'

  s.homepage         = 'https://github.com/appsmall/PLITextField'
  # s.screenshots     = 'images/example1', 'images/example2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Appsmall' => 'rahulchopra.rc93@gmail.com' }
  s.source           = { :git => 'https://github.com/appsmall/PLITextField.git', :tag => s.version.to_s }
  s.ios.deployment_target = '12.0'

  s.source_files = 'PLITextField/Classes/**/*'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
