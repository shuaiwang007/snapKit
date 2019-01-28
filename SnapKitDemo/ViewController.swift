//
//  ViewController.swift
//  SnapKitDemo
//
//  Created by 王帅 on 2019/1/24.
//  Copyright © 2019年 王帅. All rights reserved.
//

import UIKit
import SnapKit

 class ViewController: UIViewController {

    private lazy var aView = UIView()
    private lazy var bView = UIView()
    private lazy var cView = UIView()
    private lazy var dView = UIView()
    private lazy var arr = [aView, bView, cView, dView]
    private var updateConsTraint: Constraint?
    override func viewDidLoad() {
        super.viewDidLoad()
        aView.backgroundColor = UIColor.red
        view.addSubview(aView)
        bView.backgroundColor = UIColor.yellow
        view.addSubview(bView)
        cView.backgroundColor = UIColor.blue
        view.addSubview(cView)
        dView.backgroundColor = UIColor.green
        view.addSubview(dView)
        
        
//        snapTest1()
//        snapTest2()
//        snapKit3()
//        snapKit4()
//        snapKit5()
//        snapKit6()
//        snapKit7()
//        snapKit8()
//        snapKit9()
//        snapKit10()
//        snapKit11()
//        snapeKit12()
//        snapeKit13()
//        snapeKit14()
//        snapeKit15()
        snapeKit16()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        updateConstraintMethod()
    }
}

extension ViewController {
    func snapTest1() {
        aView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(100)
            make.right.equalToSuperview().offset(-50)
            make.height.equalTo(100)
        }
    }
    
    //inset
    func snapTest2() {
        let containerInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        aView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 100, left: 100, bottom: 200, right: 100))
        }
        bView.snp.makeConstraints { (make) in
            make.left.top.equalTo(aView).inset(containerInsets)
            make.bottom.right.equalTo(aView).offset(-20)
        }
    }
    
    //    lessThanOrEqualTo  <=
    func snapKit3() {
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
    }
    
    //    greaterThanOrEqualTo  >=
    func snapKit4() {
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
    }
    
    //    lessThanOrEqualTo和greaterThanOrEqualTo结合使用,注意这个问题：布局存在冲突或者矛盾的时候，而你恰好使用了lessThanOrEqualTo()或者greaterThanOrEqualTo()的时候，苹果的Auto Layout会在适当的时候给你补齐约束或者可以说优化约束，使你的布局不至于显示错误或者甚至导致程序奔溃。
    func snapKit5() {
        aView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(20)
            make.width.lessThanOrEqualTo(100)
            make.height.greaterThanOrEqualTo(500)
            make.height.equalTo(100)
        }
    }
    
    //    priority 优先级-最大1000
    func snapKit6() {
        aView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(20)
            make.width.equalTo(100).priority(777)
            make.width.equalTo(10).priority(888)
            make.height.equalTo(100)
        }
    }
    //内置优先级
    //    required > high > medium > low
    
    //    更新约束
    func snapKit7() {
        aView.snp.makeConstraints { (make) in
            self.updateConsTraint = make.left.top.equalToSuperview().offset(20).constraint
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
    }
    func updateConstraintMethod() {
        //方式1
        self.updateConsTraint?.update(inset: 150)
        //方式2
        aView.snp.updateConstraints { (make) in
            make.left.top.equalToSuperview().offset(150)
        }
    }
    
    //remarke-重新约束
    func snapKit8() {
        aView.snp.remakeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(100)
        }
    }
    
    //    dividedBy 除
    func snapKit9() {
        aView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            //宽是父视图的1/2
            make.width.equalToSuperview().dividedBy(2)
            //高是父视图的1/3
            make.height.equalToSuperview().dividedBy(3)
        }
    }
    
    //    multipliedBy 乘
    func snapKit10() {
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
    }
    
    //    safeAreaLayoutGuide
    func snapKit11() {
        aView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
        }
    }
    
    //--------------------------------snapeKit扩展--多视图批量约束--------------------------------//
    
    //多视图随机布局
    func snapeKit12() {
        arr.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)
            make.center.equalTo(CGPoint(x: CGFloat(arc4random_uniform(300)) + 50, y: CGFloat(arc4random_uniform(300)) + 50))
        }
    }
    
    //多视图统一布局
    func snapeKit13() {
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
    }
    
    //水平等分
    //axisType:方向
    //fixedSpacing:中间间距
    //leadSpacing:左边距(上边距)
    //tailSpacing:右边距(下边距)
    func snapeKit14() {
        arr.snp.distributeViewsAlong(axisType: .horizontal, fixedSpacing: 10, leadSpacing: 10, tailSpacing: 10)
        arr.snp.makeConstraints { (make) in
            make.top.equalTo(100)
            make.height.equalTo(100)
        }
    }
    
    //垂直等分
    //axisType:方向
    //fixedItemLength:item对应方向的宽或者高
    //leadSpacing:左边距(上边距)
    //tailSpacing:右边距(下边距)
    func snapeKit15() {
        arr.snp.distributeViewsAlong(axisType: .vertical, fixedItemLength: 100, leadSpacing: 70, tailSpacing: 70)
        arr.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.centerX.equalToSuperview()
        }
    }
    
    //九宫格类型
    func snapeKit16() {
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
        //        arr.snp.distributeSudokuViews(fixedItemWidth: 100, fixedItemHeight: 100, warpCount: 3, edgeInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        
    }
}
