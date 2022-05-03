Pod::Spec.new do |spec|
  spec.name                  = "ScrollFlowLabel"
  spec.version               = "1.0.2"
  spec.summary               = "Display long text on UILabel while scrolling automatically."
  spec.homepage              = "https://github.com/nnsnodnb/ScrollFlowLabel"
  spec.swift_version         = "5.0.1"
  spec.license               = { :type => "MIT", :file => "LICENSE" }
  spec.author                = { "nnsnodnb" => "nnsnodnb@gmail.com" }
  spec.social_media_url      = "https://twitter.com/nnsnodnb"
  spec.platform              = :ios
  spec.platform              = :ios, "10.0"
  spec.ios.deployment_target = "10.0"
  spec.ios.framework         = "UIKit"
  spec.source                = { :git => "https://github.com/nnsnodnb/#{spec.name}.git", :tag => "#{spec.version}" }
  spec.source_files          = "#{spec.name}", "#{spec.name}/*.{h,swift}"
  spec.public_header_files   = "#{spec.name}/#{spec.name}.h"
  spec.user_target_xcconfig = { "EXCLUDED_ARCHS[sdk=iphonesimulator*]" => "arm64" }
  spec.pod_target_xcconfig = { "EXCLUDED_ARCHS[sdk=iphonesimulator*]" => "arm64" }
end
