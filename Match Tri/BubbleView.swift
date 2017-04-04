//
//  BubbleView.swift
//  Jaws 2
//
//  Created by Vadim Bashurov on 3/29/17.
//  Copyright © 2017 vadim. All rights reserved.
//

import UIKit

class BubbleView: UIView {
    
    var faceImage: UIImageView!
    
    var a: CGFloat = 0
    var w: CGFloat = 0
    var x: CGFloat = 0
    var y: CGFloat = 0
    var u: CGFloat = 0
    var v: CGFloat = 0
    var dt: CGFloat = 0.02
    var gt: CGFloat = 350.0
    var flag = 0
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        faceImage = UIImageView(image: UIImage(named: "bt_0"))
        faceImage.frame = frame
        faceImage.isHidden = true
        
        self.addSubview(faceImage)
        let app = UIApplication.shared.delegate as! AppDelegate
        if app.iPad>0 {
            dt = 0.04
        }
        
        return
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")
    }
    
    
    func run() {
        if flag>0 {
            faceImage.transform = CGAffineTransform(rotationAngle: a)
            a += w*dt
            x += u*dt
            y += v*dt
            v -= gt*dt
            if y<0 {
                flag = 0
                faceImage.isHidden = true
            }
        }
    }
    
    
    func boom(p:CGPoint) {
        let f: CGFloat = 10
        let r: UInt32 = 20
        x = p.x
        y = p.y
        gt = 75 +  CGFloat(arc4random_uniform(50))
        u = -10 +  CGFloat(arc4random_uniform(r))
        v =  -10 - 5*CGFloat(arc4random_uniform(r))
        w = 5 + CGFloat(arc4random_uniform(10))
        x += -f + CGFloat(arc4random_uniform(20))
        y += -f + CGFloat(arc4random_uniform(20))
        faceImage.isHidden = false
        faceImage.transform = .identity
        a = 0
        
        if arc4random_uniform(10)>4 {
            w = -w
        }
        
        flag = 1
    }
    
    
}
