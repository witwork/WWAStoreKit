Pod::Spec.new do |s|
  s.name                = "WWAStoreKit"
  s.version             = "1.0"
  s.summary             = 'WWAStoreKit is library for help to use StoreKit'
  s.homepage            = 'https://codecanyon.net/user/witworkapp/portfolio'
  s.license             = 'MIT'
  s.author              = { "Witwork App" => "witwork.digital@gmail.com" }
  s.source              = { :git => 'https://github.com/witwork/WWAStoreKit.git' }
  s.social_media_url    = 'https://codecanyon.net/user/witworkapp/portfolio'

  s.platform            = :ios, '13.0'
  s.requires_arc        = true
  s.source_files        = 'Sources/WWAStoreKit/**/*.{h,m,swift}'
  s.frameworks          = 'AVFoundation', 'Foundation'
  s.public_header_files = "Sources/**/*.h"
  s.subspec 'Core' do |cs|
     cs.dependency 'SwiftDate'
     cs.dependency 'PromiseKit' 
     cs.dependency 'SwiftyStoreKit'
end
end
