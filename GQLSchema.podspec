#
# Be sure to run `pod lib lint ${POD_NAME}.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GQLSchema'
  s.version          = `git describe --abbrev=0 --tags`
  s.summary          = 'Classes for GraphQL schema'

  s.description      = 'Classes for GraphQL schema, works with "GQLSchemaGenerator"'

  s.homepage         = 'https://github.com/Lumyk/GQLSchema'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Evgeny Kalashnikov' => 'lumyk@me.com' }
  s.source           = { :git => 'https://github.com/Lumyk/GQLSchema.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.watchos.deployment_target = "3.0"
  s.swift_version = '4.2'
  s.source_files = 'Sources/**/*'
end
