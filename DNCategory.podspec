version = "0.0.1";

Pod::Spec.new do |s|
s.name = "DNCategory"
s.version = version
s.license = "MIT"
s.summary = "category"
s.homepage = "https://github.com/xiaoxionglaoshi/DNCategory"
s.authors = { "小熊老师" => "wjncode@gmail.com" }
s.source = { :git => "https://github.com/xiaoxionglaoshi/DNCategory.git", :tag => "#{version}" }
s.requires_arc = true
s.ios.deployment_target = "8.0"
s.source_files = "DNCategory", "DNCategory/*.{h}","DNCategory/**/*.{h,m}"

end