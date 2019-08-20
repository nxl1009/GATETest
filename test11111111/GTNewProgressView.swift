//
//  GTNewProgressView.swift
//  test11111111
//
//  Created by ni xiaolin on 2019/8/19.
//  Copyright © 2019 ni xiaolin. All rights reserved.
//

import UIKit

class GTNewProgressView: UIView {
    
    fileprivate var progressView : GTProgressLayerView?
    private var config : GTProgressConfig = GTProgressConfig()
    init(frame: CGRect,config:GTProgressConfig=GTProgressConfig()) {
        super.init(frame: frame)
        self.layer.cornerRadius = self.bounds.height/2
        self.clipsToBounds = true
        self.config = config
        progressView = GTProgressLayerView.init(frame: self.bounds,config: config)
        self.addSubview(progressView!)
        setProgress(progress: 0)
        self.backgroundColor = config.backgroundColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProgress(progress:CGFloat){
        let pro = progress <= 1 ? progress : 1
        let wid = self.bounds.width * pro
        self.progressView?.frame.size.width = wid
        self.progressView?.setProgress(pro: pro)
    }
}


fileprivate class GTProgressLayerView : UIView{
    private var config : GTProgressConfig = GTProgressConfig()
    
    var gradientLayer : GTNewGraidietLayer?
    var rollLayer : GTRollLayerLayer?
    init(frame: CGRect,config:GTProgressConfig=GTProgressConfig()) {
        super.init(frame: frame)
        self.layer.cornerRadius = self.bounds.height/2
        self.clipsToBounds = true
        self.config = config
        self.backgroundColor = config.progressColor
        if config.animationStyle == .gradient{
            gradientLayer = creatGradientLayer()
            self.layer.addSublayer(gradientLayer!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func creatGradientLayer()->GTNewGraidietLayer{
        let gradientLayer = GTNewGraidietLayer.init(config: self.config)
        gradientLayer.frame = self.bounds
        return gradientLayer
    }
    
    func setConfig(config:GTProgressConfig){
        self.config = config
        if config.animationStyle == .gradient{
            gradientLayer?.setConfig(config: config)
        }
    }
    
    func setProgress(pro:CGFloat){
        if config.animationStyle == .gradient{
            self.gradientLayer?.setProgress(pro: pro)
        }
    }
    
    
}
