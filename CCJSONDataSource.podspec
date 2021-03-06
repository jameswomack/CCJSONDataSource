Pod::Spec.new do |s|
  s.name     = 'CCJSONDataSource'
  s.version  = '0.2.7'
  s.license  = 'MIT'
  s.summary  = 'DRYer and more typesafe JSON API consumption.'
  s.homepage = 'https://github.com/jameswomack/CCJSONDataSource'
  s.authors  = {'James Womack' => 'me@jameswomack.com'}
  s.source   = { :git => 'https://github.com/jameswomack/CCJSONDataSource.git', :tag => '0.2.7' }
  s.source_files = 'Library/*.{h,m}'
  s.framework = 'SystemConfiguration'
  s.dependency 'Reachability'
  s.dependency 'JSONKit'
end
