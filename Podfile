platform :ios, '13.0'

abstract_target 'All' do
  use_frameworks!

  target 'VBoard' do
    pod 'SwiftFormat/CLI'
    pod 'RxCocoa',       '~> 5.0.0'
    pod 'RxSwift',       '~> 5.0.0'
    pod 'RxRelay',       '~> 5.0.0'
    pod 'RxDataSources', '~> 4.0'

    pod 'SwiftFormat/CLI'
    pod 'SwiftLint'
  end

  target 'VBoardTests' do
    pod 'Quick',         '~> 2.2.0'
    pod 'Nimble',        '~> 8.0.5'
  end

  target 'Domain' do
    pod 'RxSwift',       '~> 5.0.0'
    pod 'RxRelay',       '~> 5.0.0'
    pod 'RxDataSources', '~> 4.0'
  end

  target 'DomainTests' do
    pod 'Quick',         '~> 2.2.0'
    pod 'Nimble',        '~> 8.0.5'
  end

  target 'Infrastructure' do
    pod 'APIKit',        '~> 5.1.0'
    pod 'RxSwift',       '~> 5.0.0'
    pod 'RxRelay',       '~> 5.0.0'
  end

  target 'InfrastructureTests' do
    pod 'Quick',         '~> 2.2.0'
    pod 'Nimble',        '~> 8.0.5'
    pod 'RxTest',        '~> 5.0.0'
    pod 'RxBlocking',    '~> 5.0.0'
  end

end

