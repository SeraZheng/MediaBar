MediaBar§Introduction"MediaBar is the toolbar support common rich text editor and manage multimedia,include image as well as video";You can include it in your UIViewController for edit rich text ,capture image as well as video through camera or select image as well as video through library§Feature1.	Add rich text editor as toolbar’s item2.	Add capture image or video through camera3.	Add choose image or video through library§Adding to your  projectPodfile:platform :ios, ‘7.0’pod ‘MediaBar’, '~> 2.9.0'§PropertiesrichTextEditorimplement with instance of DTRichTextEditor,user can assign richTextEditor’s delegate or other properties§Implement delegatesThe file “AssetsDelegate.h” contains all delegates user can implement