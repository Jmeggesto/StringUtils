#
# Be sure to run `pod lib lint StringUtils.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "StringUtils"
  s.version          = "0.1.4"
  s.summary          = "A library of extensions to Swift's String."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A library of extensions to Swift's native String class
encompassing numerous features the standard library lacks,
and providing cleaner, neater API design for existing standard library features.
Features include, but are not limited to: elegant regular expression handling,
Python-style String slicing, using regular expressions to test
whether a String is convertible to Int/Float/etc and automatically
returning the numeric value.
                       DESC

  s.homepage         = "https://github.com/jmeggesto/StringUtils"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Jmeggesto" => "jackie.meggesto@gmail.com" }
  s.source           = { :git => "https://github.com/jmeggesto/StringUtils.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/jmeggesto

  s.ios.deployment_target = '8.0'

  s.source_files = 'StringUtils/Classes/**/*'

  # s.resource_bundles = {
  #   'StringUtils' => ['StringUtils/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
