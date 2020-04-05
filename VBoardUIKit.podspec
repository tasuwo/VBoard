Pod::Spec.new do |spec|
  spec.name     = 'VBoardUIKit'
  spec.version  = '0.0.1'
  spec.homepage = 'https://github.com/tasuwo/VBoard'
  spec.authors  = { 'tasuwo' => 'kamuhata.you@gmail.com' }
  spec.license  = { :type => 'NONE', :text => <<-LICENSE
                    Copyright © 2020 Tasuku Tozawa. All rights reserved.
                    LICENSE
                  }
  spec.summary  = 'UI Components for VBoard.'
  spec.source   = { :git => "git@github.com:tasuwo/VBoard.git", :branch => 'master' }

  spec.source_files = 'VBoardUIKit/**/*.swift'
  spec.resource_bundles = {
      'VBoardUIKit' => [
        'VBoardUIKit/**/*.xib',
        'VBoardUIKit/Assets.xcassets'
      ]
  }

  spec.ios.deployment_target  = '13.0'

  spec.dependency 'Kingfisher', '5.13.3'
end
