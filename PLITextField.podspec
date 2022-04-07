Pod::Spec.new do |s|
  s.name             = 'PLITextField'
  s.version          = '0.1.1'
  s.summary          = 'This library is used to add image, text field, country code picker in one view.'
  s.description      = <<-DESC

## Welcome to the PLITextField SDK

Spot.IM SDK provides an easy integration with [Spot.IM](http://www.spot.im) into a native iOS app.

Here's a sample app that shows how to use the Spot.IM SDK for iOS.

## Getting started

PLITextField is a flexible and customizable implementation of the floating label. This design enables adding context to input fields that are visible at the time of typing, while minimizing the additional space used to display this additional context. This component is used in the on signup, signin etc.

DESC

  s.homepage        = "https://github.com/appsmall/PLITextField"
  s.license         = { :type => 'MIT', :file => 'LICENSE' }
  s.author          = { 'appsmall' => 'rahulchopra.rc93@gmail.com' }
  s.platform     = :ios
  s.ios.deployment_target = '13.0'
  s.source           = { :git => 'https://github.com/appsmall/PLITextField.git', :tag => s.version.to_s }
  s.source_files          = 'Classes/*.{h,m,swift}'
end
