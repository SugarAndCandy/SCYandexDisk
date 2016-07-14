Pod::Spec.new do |s|
  s.name     = 'SCYandexDisk'
  s.version  = '0.0.5'
  s.license  = 'MIT'
  s.summary  = 'A delightful iOS and OS X networking framework.'
  s.homepage = 'http://gitlab.sugarandcandy.ru/iOS/SugarKit'
  s.social_media_url = 'https://twitter.com/AFNetworking'
  s.authors  = { 'Sugar and Candy' => 'hi@sugarandcandy.ru' }
  s.source   = { :git => 'https://github.com/SugarAndCandy/SCYandexDisk.git', :tag => s.version, :submodules => true }
  s.requires_arc = true
  s.platform     = :ios, "8.0"
  s.ios.deployment_target = "8.0"

  s.public_header_files = 'SCYandexDisk/**/*.h'
  s.source_files = 'SCYandexDisk/**/*.{m,h}'
  s.dependency 'AFNetworking'
  s.dependency 'Reachability'
end
