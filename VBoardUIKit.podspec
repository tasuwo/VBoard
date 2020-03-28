Pod::Spec.new do |spec|
  spec.name     = 'VBoardUIKit'
  spec.version  = '0.0.1'
  spec.homepage = 'https://github.com/tasuwo/VBoard'
  spec.authors  = { 'tasuwo' => 'kamuhata.you@gmail.com' }
  spec.license  = { :type => 'NONE' }
  spec.summary  = 'UI Components for VBoard.'
  spec.source   = { :git => "git@github.com:tasuwo/VBoard.git", :branch => 'master' }

  spec.source_files = 'VBoardUIKit/**/*.swift'
end
