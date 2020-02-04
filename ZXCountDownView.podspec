Pod::Spec.new do |s|
s.name         = 'ZXCountDownView'
s.version      = '1.0.5'
s.summary      = '一个简单易用的倒计时View，可用于快速创建点击获取验证码按钮。【重新进入当前页面或重启程序倒计时不会重置，仍会继续执行】'
s.homepage     = 'https://github.com/SmileZXLee/ZXCountDownView'
s.license      = 'MIT'
s.authors      = {'李兆祥' => '393727164@qq.com'}
s.platform     = :ios, '8.0'
s.source       = {:git => 'https://github.com/SmileZXLee/ZXCountDownView.git', :tag => s.version}
s.source_files = 'ZXCountDownViewDemo/ZXCountDownViewDemo/ZXCountDownView/**/*'
s.requires_arc = true
end