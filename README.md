# MK-
百思不得姐项目

# 2016.9.22
- 1.用string.length或者array.count可以判断nil或者@""情况.
- 2.可以用一个空的子控制器作为占位控制器,实现不同于一般的标签栏按钮
- 3.懒加载 用到时再创建加载
- 4.viewDidLoad方法会先加载本身控制器以及自己的子控件子视图,所以添加中间发布按钮的实现放在viewWillAppear方法中.
 
#2016.9.23
- 自定义一个标签栏
- 用layoutSubviews方法,重新布局UITabBarButton位置
- 利用懒加载,添加标签栏中间发布按钮
```Objc
#pragma mark - 懒加载中间按钮
- (UIButton *)publicBtn {

    if (!_publicBtn) {

        //标签栏的发布按钮
        _publicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_publicBtn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [_publicBtn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [_publicBtn addTarget:self action:@selector(publicClick) forControlEvents:UIControlEventTouchUpInside];
        //添加
        [self addSubview:_publicBtn];
    }
    return _publicBtn;
}
```
- #注意#在标签控制器中替换系统的标签栏,用KVC键值替换,因为系统的是只读属性
```objc
/** 更换TabBar 系统为只读 采用KVC取值**/
[self setValue:[[MKTabBar alloc] init] forKey:@"tabBar"];
```
--- 
# 2016.9.27
- 一般视图先设置尺寸,再设置中心点,不然位置不对
- 添加一个UIView的分类,用来简化对视图控件等尺寸的取值,如:
```objc
self.view.mk_width = 100;
```
- 一般在标签控制器中不要设置公用的子控制器的背景颜色等属性,这样可以利用懒加载
- 通过获得指定某种状态下的图片,来设置尺寸,不建议直接使用button.imageView.image.size,获取标题内容颜色等,与之相同
```objc
[tagBtn sizeToFit];
//tagBtn.mk_size = [UIImage imageNamed:@"MainTagSubIcon"].size;
//tagBtn.mk_size = [tagBtn imageForState:UIControlStateNormal].size;
```
- 三级控制器中不建议设置导航栏标题直接使用`self.title`
