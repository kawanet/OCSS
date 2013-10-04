Pod::Spec.new do |s|
  s.name         = "OCSS"
  s.version      = "0.0.7"
  s.summary      = "CSS Parser for iOS"
  s.homepage     = "https://github.com/kawanet/OCSS"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { "Yusuke Kawasaki" => "u-suke@kawa.net" }
  s.source       = { :git => "https://github.com/kawanet/OCSS.git", :tag => "0.0.7" }
  s.platform     = :ios, '6.0'
  s.source_files = 'src'
  s.requires_arc = true
end
