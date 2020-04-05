# -*- config: utf-8 -*-

workspace 'VBoard.xcworkspace'
project 'VBoard.xcodeproj'

use_frameworks!
platform :ios, '13.0'

def test_shared_pods
    pod 'Quick',         '~> 2.2.0'
    pod 'Nimble',        '~> 8.0.5'
end

def rx_text_shread_pods
    pod 'RxTest',        '~> 5.0.0'
    pod 'RxBlocking',    '~> 5.0.0'
end

target 'VBoard' do
  pod 'SwiftFormat/CLI'
  pod 'RxCocoa',       '~> 5.0.0'
  pod 'RxSwift',       '~> 5.0.0'
  pod 'RxRelay',       '~> 5.0.0'
  pod 'RxDataSources', '~> 4.0'

  pod 'SwiftFormat/CLI'
  pod 'SwiftLint'

  pod 'VBoardUIKit', :path => './'

  target 'VBoardTests' do
    test_shared_pods
    rx_text_shread_pods
  end
end


target 'Domain' do
  pod 'RxSwift',       '~> 5.0.0'
  pod 'RxRelay',       '~> 5.0.0'
  pod 'RxDataSources', '~> 4.0'

  target 'DomainTests' do
    test_shared_pods
  end
end


target 'Infrastructure' do
  pod 'APIKit',        '~> 5.1.0'
  pod 'RxSwift',       '~> 5.0.0'
  pod 'RxRelay',       '~> 5.0.0'

  target 'InfrastructureTests' do
    test_shared_pods
    rx_text_shread_pods
  end
end

target 'VBoardUIKitCatalog' do
  pod 'VBoardUIKit', :path => './'
end

target 'VBoardUIKitTests' do
  pod 'VBoardUIKit', :path => './'
  test_shared_pods
end

