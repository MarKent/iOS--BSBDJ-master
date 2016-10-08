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

# frame和bounds
- frame:以父视图内容起点坐标系为标准,定义某控件位置和尺寸
- bounds:以某视图里的内容起点为坐标系起点,定义某视图位置和尺寸
  - 其中bounds.origin = contentOffSet

## 系统对于UIScrollView在三级控制器中的自动偏移
- iOS7之后,对于三级控制器框架而言,会对第一个加载在控制器上的UIScrollerView进行默认的上下偏移
  `contentInset = UIEdgeInset(64,0,49,0)`
  
- 若要取消该效果,则执行:
```
self.automan....= YES;
```

## 修改UITextField的光标颜色
```objc
textField.tintColor = [UIColor whiteColor];
```
## UITextField占位符文字相关的操作
```objc
// 设置占位文字内容
@property(nullable, nonatomic,copy)   NSString               *placeholder;
// 设置带有属性的占位文字, 优先级 > placeholder
@property(nullable, nonatomic,copy)   NSAttributedString     *attributedPlaceholder;
```

## NSAttributedString
- 带有属性的字符串,富文本
- 由两部分组成
  * 文字内容:NSString *
  * 文字属性:NSDictionary
    
     - 文字颜色:NSForegroundColorAttributeName
     - 字体大小:NSFontAttributeName
     - 下划线:NSUnderlineStyleAttributeName
     - 背景色:NSBackgroundColorAttributeName
     - ......

- 修改UITextField占位文字的颜色
  - 使用attributedPlaceholder 
	```objc
	@property(nullable, nonatomic,copy)   NSAttributedString     *attributedPlaceholder;
	```
	```objc
	//修改占位符文字颜色
	self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
	```

	- 重写-(void)drawPlaceholderInRect:(CGRect)rect;
	  ```objc
	   -(void)drawPlaceholderInRect:(CGRect)rect;
	   -(void)drawPlaceholderInRect:(CGRect)rect;
	 ```

## NSMutableAttributedString
- 继承自NSAttributedString
- 使用场合
	- UILabel:attributedText
	- UITextField:attributedPlaceholder

- 初始化
```objc
NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
attributes[NSForegroundColorAttributeName] = [UIColor yellowColor];
attributes[NSBackgroundColorAttributeName] = [UIColor redColor];
attributes[NSUnderlineStyleAttributeName] = @YES;
NSAttributedString *string = [[NSAttributedString alloc] initWithString:@"123" attributes:attributes];
```

- 常见方法
```objc
//设置range范围的属性, 重复设置同一个范围的属性, 最后一次设置才是有效的(之前的设置会被覆盖掉)
-(void)setAttributes:(nullable NSDictionary<NSString *, id> *)attrs range:(NSRange)range;
//添加range范围的属性, 同一个范围, 可以不断累加属性
-(void)addAttribute:(NSString *)name value:(id)value range:(NSRange)range;
-(void)addAttributes:(NSDictionary<NSString *, id> *)attrs range:(NSRange)range;
```

- 使用实例
	- 图文混排
     ```objc
		UILabel *label = [[UILabel alloc] init];
		label.frame = CGRectMake(100, 100, 200, 25);
		label.backgroundColor = [UIColor redColor];
		label.font = [UIFont systemFontOfSize:14];
		[self.view addSubview:label];
		// 图文混排
		NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
		// 1 - 你好
		NSAttributedString *first = [[NSAttributedString alloc] initWithString:@"你好"];
		[attributedText appendAttributedString:first];
		// 2 - 图片
		// 带有图片的附件对象
		NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
		attachment.image = [UIImage imageNamed:@"header_cry_icon"];
		CGFloat lineH = label.font.lineHeight;
		attachment.bounds = CGRectMake(0, - ((label.xmg_height - lineH) * 0.5 - 1), lineH, lineH);
		// 将附件对象包装成一个属性文字
		NSAttributedString *second = [NSAttributedString attributedStringWithAttachment:attachment];
		[attributedText appendAttributedString:second];
		// 3 - 哈哈哈
		NSAttributedString *third = [[NSAttributedString alloc] initWithString:@"哈哈哈"];
		[attributedText appendAttributedString:third];
		label.attributedText = attributedText;
	  ```
	  
	- 一个label显示多行不同文字
	```objc
	UILabel *label = [[UILabel alloc] init];
	// 设置属性文字
	NSString *text = @"你好\n哈哈哈";
	NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text];
	[attributedText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(0, text.length)];
	[attributedText addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13] range:NSMakeRange(3, 3)];
	label.attributedText = attributedText;
	// 其他设置
	label.numberOfLines = 0;
	label.textAlignment = NSTextAlignmentCenter;
	label.frame = CGRectMake(0, 0, 100, 40);
	[self.view addSubview:label];
	self.navigationItem.titleView = label;
	``` 
	


