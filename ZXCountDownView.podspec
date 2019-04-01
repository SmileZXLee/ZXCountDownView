Pod::Spec.new do |s|
s.name         = 'ZXCountDownView'
s.version      = '1.0.1'
s.summary      = '一个简单易用的倒计时View，可用于例如点击获取验证码按钮，按钮被销毁后倒计时进度仍然保留，也可用于其他需要更精确严谨的情况'
s.homepage     = 'https://github.com/SmileZXLee/ZXCountDownView'
s.license      = 'MIT'
s.authors      = {'李兆祥' => '393727164@qq.com'}
s.platform     = :ios, '8.0'
s.source       = {:git => 'https://github.com/SmileZXLee/ZXCountDownView.git', :tag => s.version}
s.source_files = 'ZXCountDownViewDemo/ZXCountDownViewDemo/ZXCountDownView/**/*'
s.requires_arc = true
end