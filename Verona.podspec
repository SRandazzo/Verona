Pod::Spec.new do |s|
  s.name = 'Verona'
  s.version = '1.0.1'
  s.license = 'MIT'
  s.summary = 'Elegant, typesafe, NSAttributedString creation in Swift'
  s.homepage = 'https://github.com/SRandazzo/Verona'
  s.social_media_url = 'http://twitter.com/SalNY'
  s.authors = { 'Sal Randazzo' => 'sj.randazzo@gmail.com' }
  s.source = { :git => 'https://github.com/SRandazzo/Verona.git', :tag => s.version }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Verona/Verona.swift'

  s.requires_arc = true
end
