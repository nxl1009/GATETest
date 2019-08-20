//
//  GTRollLayerView.swift
//  test11111111
//
//  Created by ni xiaolin on 2019/8/17.
//  Copyright © 2019 ni xiaolin. All rights reserved.
//

import UIKit

public enum GTLayerAnimationStyle : Int{
    /** 滚动*/
    case roll
    /** 渐变*/
    case gradient
}
class GTProgressConfig: NSObject {
    /** 进度条展示灰色背景色*/
    var backgroundColor : UIColor = UIColor.init(white: 216/255.0, alpha: 1)
    /** 进度条颜色,去掉动画后展示的颜色*/
    var progressColor : UIColor = UIColor.init(red: 1/255.0, green: 163/255.0, blue: 119/255.0, alpha: 1)
    /** 条纹动画颜色*/
    var animationColors : (left:UIColor,right:UIColor) = ( UIColor.init(red: 45/255.0, green: 181/255.0, blue: 144/255.0, alpha: 1),UIColor.init(red: 1/255.0, green: 163/255.0, blue: 119/255.0, alpha: 1))
    /** 条纹宽度*/
    var animationWidths : (left:CGFloat,right:CGFloat) = (25,25)
    /** 每个条纹的动画时间*/
    var animationPerDuration : TimeInterval = 1.5
    /** 是否开启条纹动画*/
    var animationed : Bool = true
    /** 是否展示数字进度*/
    var showProgress : Bool = true
    /** 数字进度字体颜色*/
    var showProgressColor : UIColor = UIColor.orange
    /** 字体大小*/
    var font : CGFloat = 13
    /** 进度条高度*/
    var height : CGFloat = 10
    /** 动画效果*/
    var animationStyle : GTLayerAnimationStyle = .gradient
    /** 渐变颜色数组*/
    var gradientColors = [UIColor.blue,UIColor.purple]
}
//滚动
class GTRollLayerLayer: CALayer {
    
    var stripColor : UIColor = UIColor.init(red: 45/255.0, green: 181/255.0, blue: 144/255.0, alpha: 1)
    var stripBehindColor : UIColor = UIColor.init(red: 1/255.0, green: 163/255.0, blue: 119/255.0, alpha: 1)
    var animationDuration : TimeInterval = 1
    override func draw(in ctx: CGContext) {
        self.backgroundColor = stripBehindColor.cgColor
        let width : CGFloat = 20
        let angle : CGFloat = 5
        self.masksToBounds = false
        let count = self.bounds.width / width
        for i in 0...Int(count){
            let startPoint = CGPoint.init(x: CGFloat(i)*width*2+angle, y: 0)
            ctx.move(to: startPoint)
            ctx.addLine(to: CGPoint.init(x: startPoint.x-angle, y: self.bounds.height))
            ctx.addLine(to: CGPoint.init(x: startPoint.x-angle+width, y: self.bounds.height))
            ctx.addLine(to: CGPoint.init(x: startPoint.x+width, y: 0))
            ctx.addLine(to: startPoint)
            ctx.closePath()
        }
        ctx.setFillColor(stripColor.cgColor)
        ctx.setStrokeColor(stripBehindColor.cgColor)
        ctx.drawPath(using: CGPathDrawingMode.fillStroke)
        
    }
    
    func setAnimated(){
        let animation2 = CABasicAnimation.init(keyPath: "position.x")
        animation2.beginTime = 0
        animation2.isRemovedOnCompletion = false
        animation2.duration = animationDuration
        animation2.fromValue = 0
        animation2.toValue = 40
        animation2.repeatCount = MAXFLOAT
        self.add(animation2, forKey: "eee")
    }
}


//渐变
class GTNewGraidietLayer : CAGradientLayer{
    private var config : GTProgressConfig = GTProgressConfig()
    private var progress : CGFloat = 1
    init(config:GTProgressConfig=GTProgressConfig()){
        super.init()
        self.config = config
        self.setNeedsDisplay()
    }
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(in ctx: CGContext) {
        self.colors = getColors()
        self.startPoint = CGPoint.init(x: 0, y: 0.5)
        self.endPoint = CGPoint.init(x: progress, y: 0.5)
    }
    
    private func getColors()->[CGColor]{
        var colors : [CGColor] = []
        for color in config.gradientColors{
            colors.append(color.cgColor)
        }
        return colors
    }
    func setProgress(pro:CGFloat){
        self.progress = pro
        self.setNeedsDisplay()
    }
    //修改属性
    func setConfig(config:GTProgressConfig){
        self.config = config
        self.setNeedsDisplay()
    }
}
