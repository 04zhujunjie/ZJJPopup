
# ZJJPopup   

### 效果图
![image](https://github.com/04zhujunjie/ZJJPopup/blob/main/ZJJPopup.gif)

### 特点：
1、弹窗可以选择显示在window，viewController, navigationController上  
2、弹窗的样式可以通过 ZJJPopupModel对象来设置   
3、可以自定义弹窗 ,支持毛玻璃效果     
4、提供默认的选择器（UIPickerView和UITableView）的弹框        
5、弹窗的头部视图，可以根据文本标题和按钮文本来动态调节头部视图的高度  

### 弹窗的样式设置：      
可以通过ZJJPopupModel对象来进行设置
   
```
struct ZJJPopupModel {
    
    var animationType:ZJJPopupAnimationType = .move //弹框出现样式
    var showInType:ZJJPopupViewShowInType = .window //弹框添加到哪里，默认是在window上
    var popupViewRadius:CGFloat = 10 //设置popupView的圆角
    var isTouchHidden:Bool = true //点击遮罩层，是否隐藏弹框视图
    var isConfirmHidden:Bool = true //点击确定按钮，是否隐藏弹框视图
    var contentViewMinHeight:CGFloat = 220 //contentView内容的最小高度
    var maskLayerColor:UIColor = UIColor.init(red:0, green: 0, blue:0, alpha: 0.5) //遮罩层的颜色
    var blurEffectStyle:ZJJBlurEffectStyle = .none //设置毛玻璃效果,设置为none，显示遮罩层的颜色
    var backgroundColor:UIColor = .white{
        didSet{
            self.topViewConfig.backgroundColor = backgroundColor
        }
    } //背景颜色
    
    var topViewConfig:ZJJPopupTopViewConfig = ZJJPopupTopViewConfig() //topView配置
    }

```

### 如何使用默认的弹窗选择器（UIPickerView和UITableView）

#### 一、创建的数据结构体或者模型对象遵循 ZJJOptionProtocol协议，jj_optionValue值是作为选择器列表中显示的值
```
protocol ZJJOptionProtocol {
    var jj_optionValue:String?{set get} 
}
```

#### 二、创建ZJJPopupModel对象来设置弹窗的样式，创建ZJJOption对象来存储要显示的选择列表数据和列表中选中的数据
```
struct  ZJJOption {
    var optionArray:[ZJJOptionProtocol] = [] //选择的列表
    var selectModel:ZJJOptionProtocol? //选择的对象
}
```

#### 三、可以使用ZJJPopup提供的便捷的方法，如果需要自定义选择器或者自定义弹窗，可以参照ZJJPopup内部的实现
   
