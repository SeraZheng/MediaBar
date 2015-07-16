Pod::Spec.new do |s|
  s.name         = 'MediaBar'
  s.version      = '1.0.0'
  s.summary      = 'MediaBar is the toolbar support common rich text editor and manage multimedia,include image as well as video'
  s.description  = <<-DESC
                   A longer description of MediaBar in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                  * Try to keep it short, snappy and to the point.
                  * Finally, don't worry about the indent, CocoaPods strips it!
                  DESC
  s.homepage     = 'https://github.com/sjzc/MediaBar'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { 'sera' => '462970213@qq.com' }
  s.platform     = :ios, '7.0'
  s.source       = { :git => 'https://github.com/sjzc/MediaBar.git', :tag => '1.0.0' }
  s.source_files  = 'MediaBar/*.{h,m}'
  s.resources  = 'Resource/*.png'
  s.frameworks = 'MediaPlayer', 'AssetsLibrary', 'UIKit', 'Foundation'
  s.requires_arc = true
  s.dependency 'CTAssetsPickerController', '~> 2.9.5'
  s.dependency 'DTRichTextEidtor'
end
