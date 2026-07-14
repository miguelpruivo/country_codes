#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint country_codes.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'country_codes'
  s.version          = '0.0.1'
  s.summary          = 'Country codes helper for Flutter.'
  s.description      = <<-DESC
Country codes helper that provides country details from the device locale.
                       DESC
  s.homepage         = 'https://github.com/miguelpruivo/country_codes'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Miguel Ruivo' => 'miguelpruivo@gmail.com' }

  s.source           = { :path => '.' }
  s.source_files     = 'country_codes/Sources/country_codes/**/*.swift'
  s.dependency 'FlutterMacOS'

  s.platform = :osx, '10.15'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
