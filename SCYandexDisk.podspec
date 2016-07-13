Pod::Spec.new do |s|
  s.name     = 'SugarKit'
  s.version  = '0.0.7'
  s.license  = 'MIT'
  s.summary  = 'A delightful iOS and OS X networking framework.'
  s.homepage = 'http://gitlab.sugarandcandy.ru/iOS/SugarKit'
  s.social_media_url = 'https://twitter.com/AFNetworking'
  s.authors  = { 'Mattt Thompson' => 'm@mattt.me' }
  s.source   = { :git => 'http://gitlab.sugarandcandy.ru/iOS/SugarKit.git', :tag => s.version, :submodules => true }
  s.requires_arc = true
  s.platform     = :ios, "8.0"
  s.ios.deployment_target = "8.0"

  s.public_header_files = 'SugarKit/SugarKit.h'
  s.source_files = 'SugarKit/SugarKit.h'
  
  s.subspec 'Importer' do |sp|
    sp.source_files = 'SugarKit/*.{h,m}'
    sp.public_header_files = 'SugarKit/*.h'
    sp.frameworks = 'CoreData'
    sp.dependency "MagicalRecord"
  end
end
