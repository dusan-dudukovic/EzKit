Pod::Spec.new do |spec|

  spec.name         = "EzKit-Pod"
  spec.version      = "0.3.1"
  spec.summary      = "Easy to use, animated UIView subclasses, with selection and highlighting logic."
  spec.description  = <<-DESC
                     EzKit is a collection of custom UIKit components, based on EzView - selectable and highlightable UIView subclass. All interaction is animated and delegated, with high customization options. Need a button with 2 labels and 2 images? I got you! An out of the box, animated checkbox in UIKit? Ez.
                   DESC

  spec.homepage     = "https://github.com/dusan-dudukovic/EzKit"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "Dušan Duduković" => "https://github.com/dusan-dudukovic.git" }
  spec.social_media_url   = "https://www.linkedin.com/in/dusan-dudukovic/"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  spec.platform     = :ios, "13.0"

  # spec.ios.deployment_target = "13.0"
  # spec.osx.deployment_target = "11.0"
  # spec.watchos.deployment_target = "5.0"
  # spec.tvos.deployment_target = "14.0"
  # spec.visionos.deployment_target = "1.0"
  
  spec.swift_versions = ['5.9']

  spec.source       = { :git => "https://github.com/dusan-dudukovic/EzKit.git", :tag => "#{spec.version}" }
  spec.source_files  = "Sources/**/*.swift"

end
