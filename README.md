# HSLineStyleActionSheet

###说明
================
线性ActionSheet，可以用来做分享，工具栏

- 支持多行按钮，单行按钮超出屏幕可以滑动
- 自定义每行标题，也可以不带标题
- 支持屏幕旋转

###更新
================
2016年07月22日更新 beta 0.0.1发布

###截图
================
【截图1】
![image](https://raw.githubusercontent.com/cnthinkcode/HSLineStyleActionSheet/master/ScreenShot1.png)

【截图2】
![image](https://raw.githubusercontent.com/cnthinkcode/HSLineStyleActionSheet/master/ScreenShot2.png)

###使用
================
直接将HSLineStyleActionSheet拖拽到项目，强烈建议像demo中HSShareSheet一样，继承以后使用，在需要使用的地方写几句代码就可以，降低耦合性
####需要实现以下代理方法
```objc
//设置HSLineStyleActionSheet的行数
- (NSInteger)numberOfRowsInLineStyleActionSheet:(HSLineStyleActionSheet *)lineActionSheet;
//设置每行按钮的个数
- (NSInteger)lineStyleActionSheet:(HSLineStyleActionSheet *)lineActionSheet numberOfItemsInRow:(NSInteger)row;
//使用HSLineStyleActionSheetItem为按钮提供图片和标题
- (HSLineStyleActionSheetItem *)lineStyleActionSheet:(HSLineStyleActionSheet *)lineActionSheet itemAtIndexPath:(NSIndexPath *)indexPath;
//点选按钮的索引 indexPath.section表示行，indexPath.item表示列
- (void)lineStyleActionSheet:(HSLineStyleActionSheet *)lineActionSheet touchAtIndexPath:(NSIndexPath *)indexPath;
```
####具体用法请查看demo的HSShareSheet.h/m 文件
###TODO
================
-   调整优化代码结构
-   添加Block调用