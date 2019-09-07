#
# Be sure to run `pod lib lint iOSCustomTransitions.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'iOSCustomTransitions'
  s.version          = '0.1.0'
  s.summary          = 'iOS Custom Transitions is a library that provides simpleUIViewController customized transition'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
iOSCustomTransitions provides two beautiful customized UIViewController transitions to improve the app UX. To use custom transitions your UIViewController needs to conform to UIViewControllerTransitioningDelegate.
                       DESC

  s.homepage         = 'https://github.com/charleslima/iOS-Custom-Transitions'
  # s.screenshots     = 'https://github.com/charleslima/iOS-Custom-Transitions/blob/master/iOSCustomTransitions/iOSCustomTransitions/Assets/animationExample.gif'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'charleslima' => 'jlima.charles@gmail.com' }
  s.source           = { :git => 'https://github.com/charleslima/iOS-Custom-Transitions.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Classes/*'
  
  s.swift_version = '4.0'

  # s.resource_bundles = {
  #   'iOSCustomTransitions' => ['iOSCustomTransitions/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
