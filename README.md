# UITableViewCellAutoHeight
关于UITableViewCell加载字符串时高度自适应的demo
`UITableView`，在使用当中经常会遇到一些根据数据源动态调节`cell`的高度，这种情况在 `cell`上加载文字信息尤为常见，这里我总结两种自己经常用的方法。

- 3.31更新：无论哪种方法加上`self.tableView.estimatedRowHeight = kScreenHeight;`的运行效率更高。可以减少计算量。内存黑CPU在多（测试时用了1000。。。）`row`下都有下降

# 兼容iOS8之前版本
 主要方法： 
```- (CGRect)boundingRectWithSize:(CGSize)size options:(NSStringDrawingOptions)options attributes:(nullable NSDictionary<NSString *, id> *)attributes context:(nullable NSStringDrawingContext *)context NS_AVAILABLE(10_11, 7_0);```
`NSString`的对象方法，可以计算字符串在`UILable`固定宽度、固定字体大小下所需的`size`，返回值是`CGRect`类型，但我们一般只需要高度就可以了。
这里我自定义一个`TableViewCell`
![1.png](http://upload-images.jianshu.io/upload_images/1251095-29793ecf9a738c39.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)约束做好，需要注意的是｀`label`高度不做约束下面的`label`要对`cell`的`ContentView`作底部约束。
数据源：```
self.dataSource = @[@"The first step to creating a fancy animation was creating a UITableViewCell (called BookCell) with flexible constraints. By flexible, I mean that no constraint was absolutely required. The cell included a yellow subview subview with a collapsible height constraint — the height constraint always has a constant of 0, and it initially has a priority of 999. Within the collapsible subview, no vertical constraints are required. We set the priority of all the internal vertical constraints to 998.", @"如《广东省工资支付条例》第三十五 条非因劳动者原因造成用人单位停工、停产，未超过一个工资支付周期（最长三十日）的，用人单位应当按照正常工作时间支付工资。超过一个工资支付周期的，可以根据劳动者提供的劳动，按照双方新约定的标准支付工资；用人单位没有安排劳动者工作的，应当按照不低于当地最低工资标准的百分之八十支付劳动者生活费，生活费发放至企业复工、复产或者解除劳动关系。,来看看劳动法克林顿刷卡思考对方卡拉卡斯的楼房卡拉卡斯的疯狂拉萨的罚款 ,中秋节、十一假期分为两类。一类是法定节假日，即9月30日(中秋节)、10月1日、2日、3日共四天为法定节假日;另一类是休息日，即10月4日至10月7日为休息日。"];```
然后关键的计算的`cell`的高度部分了：
```
 -(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *str1 = self.dataSource[0];
    NSString *str2 = self.dataSource[1];
    
    CGFloat height1 = [str1 boundingRectWithSize:CGSizeMake(kScreenWidth - 8, 99999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13]} context:nil].size.height;
    CGFloat height2 = [str2 boundingRectWithSize:CGSizeMake(kScreenWidth - 8, 99999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13]} context:nil].size.height;
    
    return height1 + height2 + 145 - 16 * 2;
}
```
其中`CGSizeMake(kScreenWidth - 8, 99999) `部分`width`参数屈居于`cell`中的`label`距离`cell.contentView`边缘距离，需要注意的是，如果我们用`xib`做约束
![2.png](http://upload-images.jianshu.io/upload_images/1251095-faad6652b77954d5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)`Constrain to margins`打上对勾时默认距离变远8像素，然后` return height1 + height2 + 145 - 16 * 2;`中145室xib中`cell`的高度，16是`label`在不加高度约束时的默认高度，这样就完成了。
运行出来就是我们想要的结果
![IMG_0026.PNG](http://upload-images.jianshu.io/upload_images/1251095-15b61b5398a9fc86.PNG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

# 只兼容兼容iOS8之后的版本
主要方法：
```
self.tableView.estimatedRowHeight = 44.0f;
self.tableView.rowHeight = UITableViewAutomaticDimension;
```
把```- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath```
注掉，直接运行，也能得到上面的效果。
