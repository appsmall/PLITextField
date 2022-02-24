----Pod::Spec.new do |s|
s.name             = 'PLITextField'  
s.version          = '0.1.0'  
s.summary          = 'This library is used to create custom text field and show icons, label and country code fields' 
s.description      = <<-DESC 'This library is used to create custom text field and show icons, label and country code fields....'
DESC

s.homepage         = 'https://github.com/appsmall/PLITextField' 
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'appsmall' => 'rahulchopra.rc93@gmail.com' } 
s.source           = { :git => 'https://github.com/appsmall/PLITextField.git', :tag => s.version.to_s }
s.ios.deployment_target = '13.0'
s.source_files = 'PLITextField/Classes/*'  
end