[TOC]
# snapKit用法实践 
## snapKit常规用法
snaptKit 是masonry的swift版本，布局方便，然后我们来看看在项目中都有哪些用处吧~

`例子1：` 创建一个aview，距父view左边、上边100，右边50，高100

```Swift
aView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(100)
            make.right.equalToSuperview().offset(-50)
            make.height.equalTo(100)
        }
```
`例子2：` inset：提供了方便的inset语法，直接约束edgeInsets
```Swift
let containerInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
 aView.snp.makeConstraints { (make) in
    make.edges.equalToSuperview().inset(UIEdgeInsets(top: 100, left: 100, bottom: 200, right: 100))
 }
 bView.snp.makeConstraints { (make) in
      make.left.top.equalTo(aView).inset(containerInsets)
      make.bottom.right.equalTo(aView).offset(-20)
 }
```
`例子3：` lessThanOrEqualTo: <= 约束边界的最大值, 使bView的centerX <= aView的左边
```Swift
aView.snp.makeConstraints { (make) in
     make.left.top.equalToSuperview().offset(20)
     make.width.equalTo(100)
     make.height.equalTo(100)
}
bView.snp.makeConstraints { (make) in
    make.top.equalTo(aView.snp.bottom).offset(20)
    make.width.height.equalTo(100)
    make.centerX.lessThanOrEqualTo(aView.snp.left)
}
```
`例子4：` greaterThanOrEqualTo： >= 约束边界的最小值， 使aView的左边 >= bView的左边
```Swift
aView.snp.makeConstraints { (make) in
    make.left.top.equalToSuperview().offset(20)
    make.width.equalTo(100)
    make.height.equalTo(100)
}
bView.snp.makeConstraints { (make) in
    make.top.equalTo(aView.snp.bottom).offset(20)
    make.width.height.equalTo(100)
    make.left.greaterThanOrEqualTo(aView.snp.left)
}

```
`例子5：` lessThanOrEqualTo和greaterThanOrEqualTo结合使用, **注意这个问题**：布局存在冲突或者矛盾的时候，而你恰好使用了lessThanOrEqualTo()或者greaterThanOrEqualTo()的时候，苹果的Auto Layout会在适当的时候给你补齐约束或者可以说优化约束，使你的布局不至于显示错误或者甚至导致程序奔溃。
如下例子，<=100 >=500 显然是不对的，但是并不会crash，Auto Layout会在适当的时候优化约束
```Swift
aView.snp.makeConstraints { (make) in
    make.left.top.equalToSuperview().offset(20)
    make.width.lessThanOrEqualTo(100)
    make.height.greaterThanOrEqualTo(500)
    make.height.equalTo(100)
}
```
`例子6：` priority-优先级,**注意：优先级最大值为1000，大于1000会导致crash**，如下例子，width最后等于10
```Swift
aView.snp.makeConstraints { (make) in
    make.left.top.equalToSuperview().offset(20)
    make.width.equalTo(100).priority(777)
    make.width.equalTo(10).priority(888)
    make.height.equalTo(100)
}
内置优先级：required > high > medium > low
```
`例子7：` 更新约束 update
```Swift
 aView.snp.makeConstraints { (make) in
    make.left.top.equalToSuperview().offset(20)
    make.width.equalTo(100)
    make.height.equalTo(100)
}
func updateConstraintMethod() {
    //方式1-可以将要改变的约束记录成成员变量，然后更新
    //self.updateConsTraint?.update(inset: 150)
    //方式2
    aView.snp.updateConstraints { (make) in
        make.left.top.equalToSuperview().offset(150)
    }
}
```
`例子8：` 重新约束-remarke

```Swift
  aView.snp.remakeConstraints { (make) in
        make.center.equalToSuperview()
        make.width.height.equalTo(100)
    }
```
`例子9：` dividedBy 除,如下例子，使aView的宽等于父view的1/2,高等于父view的1/3.

```Swift
aView.snp.makeConstraints { (make) in
    make.center.equalToSuperview()
    //宽是父视图的1/2
    make.width.equalToSuperview().dividedBy(2)
    //高是父视图的1/3
    make.height.equalToSuperview().dividedBy(3)
}
```
`例子10：` multipliedBy 乘，如下例子，使bView的宽是aView的3倍，高是aView的5倍

```Swift
aView.snp.makeConstraints { (make) in
    make.width.height.equalTo(50)
    make.top.equalTo(20)
    make.centerX.equalToSuperview()
}
bView.snp.makeConstraints { (make) in
    make.center.equalToSuperview()
    //宽是aView的3倍
    make.width.equalTo(aView).multipliedBy(3)
    //高是aView的5倍
    make.height.equalTo(aView).multipliedBy(5)
}
```
`例子11：` safeAreaLayoutGuide-安全区域的问题，适配齐刘海，要相对于安全区域进行约束
```Swift
aView.snp.makeConstraints { (make) in
    make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
    make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
    make.left.right.equalToSuperview()
}
```
## snapKit扩展
snapKit不支持多视图批量约束，但是我们想使用这种便捷高效的功能，怎么办呢？对snapKit进行扩展
`例子12：` 多视图随机布局,arr是view数组
```Swift
arr.snp.makeConstraints { (make) in
    make.width.height.equalTo(100)
    make.center.equalTo(CGPoint(x: CGFloat(arc4random_uniform(300)) +   50, y: CGFloat(arc4random_uniform(300)) + 50))
    }
```
`例子13：` 多视图统一布局,对arr里的view统一设置宽高，然后分别设置各个view的top
```Swift
arr.snp.makeConstraints { (make) in
    make.width.height.equalTo(100)
}
aView.snp.makeConstraints { (make) in
    make.top.equalTo(0)
}
bView.snp.makeConstraints { (make) in
    make.top.equalTo(100)
}
cView.snp.makeConstraints { (make) in
    make.top.equalTo(200)
}
dView.snp.makeConstraints { (make) in
    make.top.equalTo(300)
}
```
`例子14：` 水平等分
```Swift
//axisType:方向
//fixedSpacing:中间间距
//leadSpacing:左边距(上边距)
//tailSpacing:右边距(下边距)
arr.snp.distributeViewsAlong(axisType: .horizontal, fixedSpacing: 10, leadSpacing: 10, tailSpacing: 10)
arr.snp.makeConstraints { (make) in
    make.top.equalTo(100)
    make.height.equalTo(100)
}
```
`例子15：` 垂直等分
```Swift
//axisType:方向
//fixedItemLength:item对应方向的宽或者高
//leadSpacing:左边距(上边距)
//tailSpacing:右边距(下边距)
arr.snp.distributeViewsAlong(axisType: .vertical, fixedItemLength: 100, leadSpacing: 70, tailSpacing: 70)
arr.snp.makeConstraints { (make) in
    make.width.equalTo(100)
    make.centerX.equalToSuperview()
}
```
`例子16：` 九宫格类型
```Swift
var arr: Array<ConstraintView> = []
for _ in 0..<9 {
    let subview = UIView()
    subview.backgroundColor = UIColor.red
    view.addSubview(subview)
    arr.append(subview)
}
//大小固定、上下左右默认为0的九宫格
arr.snp.distributeSudokuViews(fixedItemWidth: 100, fixedItemHeight: 100, warpCount: 3)
//更改边距
//arr.snp.distributeSudokuViews(fixedItemWidth: 100, fixedItemHeight: 100, warpCount: 3, edgeInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    
}
```
**extension及文中代码见[demo](https://github.com/shuaiwang007/snapKit.git)**