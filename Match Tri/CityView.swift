//
//  CityView.swift
//  Zabivaka
//
//  Created by vadim on 11/7/16.
//  Copyright © 2016 vadim. All rights reserved.
//

import UIKit

class CityView: UIView {

    let colors:[UIColor] = [UIColor.black,
                            UIColor(patternImage: UIImage(named: "b_19")!),
                            UIColor(patternImage: UIImage(named: "b_20")!),
                            UIColor(patternImage: UIImage(named: "b_21")!),
                            UIColor(patternImage: UIImage(named: "b_22")!),
                            UIColor(patternImage: UIImage(named: "b_23")!),
                            UIColor(patternImage: UIImage(named: "b_24")!),
                            UIColor(patternImage: UIImage(named: "b_25")!),
                            UIColor(patternImage: UIImage(named: "b_25")!),
                            ]
    
    
    func renderBlink(_ t:Convex)
    {
        let path = UIBezierPath()
        let strokeColor = UIColor.black
        strokeColor.setStroke()
        var i = 0
        for p in t.vtx {
            if i == 0 {
                i = 1
                path.move(to: p)
            } else {
                path.addLine(to: p)
            }
        }
        let fillColor = UIColor.white
        fillColor.setFill()
        path.fill(with: .lighten, alpha: 0.7)
        path.lineWidth = 1.0
        path.stroke()
    }
    
    
    func renderSimple(_ t:Convex)
    {
        let path = UIBezierPath()
        let strokeColor = UIColor.black
        strokeColor.setStroke()
        path.lineWidth = 1.0
        let clr = t.color
        var i = 0
        for p in t.vtx {
            if i == 0 {
                i = 1
                path.move(to: p)
            } else {
                path.addLine(to: p)
            }
        }
        if clr>0 {
            let fillColor = colors[clr]
            fillColor.setFill()
            path.fill()
        }
        path.stroke()
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let app = UIApplication.shared.delegate as! AppDelegate
        let menu = app.menu
        for t in menu.hulls  {
            if t.color>0 {
                renderSimple(t)
            }
        }
    }
    
}
