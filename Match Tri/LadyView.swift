//
//  LadyView.swift
//  Election Balls
//
//  Created by Vadim Bashurov on 10/13/16.
//  Copyright © 2016 Vadim Bashurov. All rights reserved.
//

import UIKit

class LadyView: UIView {
    let fontName = "Troika"
    
    var lImage: UIImageView!
    var cImage: UIImageView!
    var rImage: UIImageView!
    var b: UIButton!
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        lImage = UIImageView(image: UIImage(named: "g_14"))
        lImage.frame = CGRect(x: 6,y: 12,width: 18,height: 18)

        rImage = UIImageView(image: UIImage(named: "g_13"))
        rImage.frame = CGRect(x: 44,y: 12,width: 18,height: 18)

        cImage = UIImageView(image: UIImage(named: "g_12"))
        cImage.frame = CGRect(x: 22,y: 0,width: 25,height: 25)
        
    
        b = UIButton(frame: CGRect(x: 9,y: 20,width: 48, height: 48))
        b.setBackgroundImage(UIImage(named: "g_8"), for: UIControlState())
        
        b.titleLabel?.font = UIFont(name: fontName, size: 21)
        
        
        b.setTitleColor(UIColor.white, for: .normal)
        self.addSubview(b)
        self.addSubview(lImage)
        self.addSubview(rImage)
        self.addSubview(cImage)
        
        return
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")
    }
    
    func setState(_ stars: Int, bType:Int) {
  
        rImage.isHidden = stars>3 ? false : true
        lImage.isHidden = stars>2 ? false : true
        cImage.isHidden = stars>1 ? false : true
        
        b.isEnabled = stars>0 ? true : false
        b.alpha = stars>0 ? 1 : 0.5
        
        switch bType {
        case 0:
            b.setBackgroundImage(UIImage(named: "g_8"), for: UIControlState())
        case 1:
            b.setBackgroundImage(UIImage(named: "g_7"), for: UIControlState())
        case 2:
            b.setBackgroundImage(UIImage(named: "b_14"), for: UIControlState())
        default:
            print("state?")
        }
        
    }
    
}



