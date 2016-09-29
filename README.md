# MK-
##百思不得姐项目

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
 //tagBtn.mk_size = [UIImage  imageNamed:@"MainTagSubIcon"].size;
 //tagBtn.mk_size = [tagBtn imageForState:UIControlStateNormal].size;
```
- 三级控制器中不建议设置导航栏标题直接使用`self.title`

# 2016.9.28
- 一般抽取某些公用的功能时,先考虑分类,再考虑写新的类

# 2016.9.29
- 自定义一个导航控制器,在

```
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
```

- 方法中自定义返回按钮样式,统一共有的需求
	- 代码如下:
	
```objc
	- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
	//判断并不是所有的子控制器中都需要
    if (self.childViewControllers.count >0) {
        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backBtn sizeToFit];//要在内容便宜设置之前设置
        backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [backBtn addTarget:self action:@selector(backCick) forControlEvents:UIControlEventTouchUpInside];       viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    //父类调用 建议写在后面,先定义好子控制器的元素,再push
    [super pushViewController:viewController animated:YES];
}
- (void)backCick {
    
    [self popViewControllerAnimated:YES];
}
```	
# 2016.9.29
- 因为自定义了UIBarButtonItem,所以通过下面的这方法重新设置默认的pop手势响应 

```
self.interactivePopGestureRecognizer.delegate = self;
```

- 在代理方法中判断当前导航控制器的子控制器个数是否>1,如果是则响应默认pop手势,否则不响应.
  - 如果不判断,则会出现第一个子控制器被pop手势后,第二个子控制器无法push. 代码如下:

```objc
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {

    //当子控制器个数只有一个时,不响应手势
    return self.childViewControllers.count > 1;
}

```


