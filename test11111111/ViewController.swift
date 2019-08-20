//
//  ViewController.swift
//  test11111111
//
//  Created by ni xiaolin on 2019/8/17.
//  Copyright © 2019 ni xiaolin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let aaa = UIView.init(frame: CGRect.init(x: 10, y: 100, width: 200, height: 30))
//        aaa.layer.cornerRadius = 15
//        aaa.clipsToBounds = true
//        aaa.tag = 10
//        let la = GTRollLayerLayer.init()
//        la.backgroundColor = UIColor.blue.cgColor
//        la.frame = CGRect.init(x: 0, y: 0, width: self.view.bounds.width*2, height: 30)
//        la.setNeedsDisplay()
//        la.cornerRadius = la.bounds.height/2
//
//        la.setAnimated()
//        aaa.layer.addSublayer(la)
//        self.view.addSubview(aaa)
        
        let bb = GTNewProgressView.init(frame: CGRect.init(x: 10, y: 100, width: 200, height: 30))
        bb.tag = 10
        self.view.addSubview(bb)
    }
    var progress : CGFloat = 0
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        progress += 0.1
        let v = self.view.viewWithTag(10) as! GTNewProgressView
        v.setProgress(progress: progress)
    }
}

