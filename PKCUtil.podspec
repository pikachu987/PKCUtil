#
# Be sure to run `pod lib lint PKCUtil.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'PKCUtil'
s.version          = '0.1.7'
s.summary          = 'Util made easy to write for each project'
s.description      = 'I always use copy / paste for each project, so I think it would be more convenient to use library for cocoapods.'

s.homepage         = 'https://github.com/pikachu987/PKCUtil'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'pikachu987' => 'pikachu987@naver.com' }
s.source           = { :git => 'https://github.com/pikachu987/PKCUtil.git', :tag => s.version.to_s }

s.ios.deployment_target = '8.0'

s.source_files = 'PKCUtil/Classes/**/*'

end
