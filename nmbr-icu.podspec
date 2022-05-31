#
# Be sure to run `pod lib lint nmbr.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'nmbr-icu'
  s.version          = '0.1.0'
  s.summary          = 'A number formatter specifically for rounding large numbers'

  s.description      = <<-DESC
  A locale-aware number formatter to deal with shorter versions of large numbers.
  i.e. 1,000,000 would be either "1M" or "1 million" in en_GB.

  Deals with other locales grouping of digits (i.e. Japan groups by 4, and India groups by 3 then 2)
                       DESC

  s.homepage         = 'https://github.com/kerrmarin/nmbr-icu'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'kerr marin miller' => 'kerr@kerrmarin.com' }
  s.source           = { :git => 'https://github.com/kerrmarin/nmbr-icu.git', :tag => "v"+s.version.to_s }

  s.swift_versions = [ '4.0', '4.2', '5.0' ]
  s.static_framework = true
  s.ios.deployment_target = '14.0'

  s.source_files = 'nmbr/Classes/**/*'

  s.library = 'c++'

  s.public_header_files = [ "nmbr/Classes/NMBRFormatter.h" ]

  s.dependency 'icu4c-iosx'

end
