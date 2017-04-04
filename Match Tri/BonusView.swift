//
//  BonusView.swift
//  halves2048
//
//  Created by Vadim Bashurov on 1/21/17.
//  Copyright © 2017 vadim. All rights reserved.
//

import UIKit




protocol BonusViewDelegate {
    func pressContinue()
}

class BonusView: UIView {
    
    var delegate: BonusViewDelegate?
    
    var titleMessage: UILabel!
    
    var msg1: UILabel!
    var msg2: UILabel!
    
    let fontName = "Troika"
    
    var bonusImage: UIImageView!
    
    var exit: UIButton!
    
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 320, height: 568) )
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        
        
        let ground = UIImageView(image: UIImage(named: "g_31"))
        ground.frame = CGRect(x: 0,y: 60,width: 320,height: 400)
        
        self.addSubview(ground)
        
        
        let s = UIImageView(image: UIImage(named: "g_16"))
        s.frame = CGRect(x: 67,y: 350, width: 38,height: 57)
        self.addSubview(s)
        
        
        
        bonusImage = UIImageView(image: UIImage(named: "b_24"))
        bonusImage.frame = CGRect(x: 0,y: 0,width: 160,height: 160)
        bonusImage.center = CGPoint(x: 160, y: 245)
        
        exit = UIButton(frame: CGRect(x: 0,y: 0,width: 240, height: 320))
        exit.setBackgroundImage(UIImage(named: "empty"), for: UIControlState())
        exit.center = CGPoint(x: 160, y: 275)
        
        
        
        titleMessage = UILabel(frame: CGRect(x: 0,y: 0,width: 280, height: 35))
        titleMessage.font = UIFont(name: fontName, size: 31)
        titleMessage.center = CGPoint(x: 160, y: 115)
        titleMessage.text = "Got new item"
        titleMessage.textColor = UIColor.yellow
        titleMessage.textAlignment = .center
        self.addSubview(titleMessage)
        
        
        msg1 = UILabel(frame: CGRect(x: 0,y: 0,width: 200, height: 25))
        msg1.font = UIFont(name: fontName, size: 25)
        msg1.center = CGPoint(x: 220, y: 364)
        msg1.text = "Amazing"
        msg1.textColor = UIColor.white
        msg1.textAlignment = .left
        self.addSubview(msg1)
        
        
        msg2 = UILabel(frame: CGRect(x: 0,y: 0,width: 200, height: 21))
        msg2.font = UIFont(name: fontName, size: 21)
        msg2.center = CGPoint(x: 220, y: 392)
        msg2.text = "U'r still alive"
        msg2.textColor = UIColor.white
        msg2.textAlignment = .left
        self.addSubview(msg2)
        
        self.addSubview(bonusImage)
        self.addSubview(exit)
        
        exit.addTarget(self, action: #selector(BonusView.continuePressed(_:)), for: .touchUpInside)
        
        return
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")
    }
    
    
    func prepareToMission(_ level:Int, score:Int, stars:Int) {
        switch stars {
        case 1:
            titleMessage.text = "cup of coffee"
            bonusImage.image =  UIImage(named: "b_25")
        case 2:
            titleMessage.text = "got new fridge"
            bonusImage.image =  UIImage(named: "b_22")
        case 3:
            titleMessage.text = "got new TV"
            bonusImage.image =  UIImage(named: "b_23")
        case 4:
            titleMessage.text = "got new piano"
            bonusImage.image =  UIImage(named: "b_24")
        case 5:
            titleMessage.text = "got new sofa"
            bonusImage.image =  UIImage(named: "bt_2")
        case 6:
            titleMessage.text = "got new chair"
            bonusImage.image =  UIImage(named: "b_20")
        case 7:
            titleMessage.text = "chest of drawers"
            bonusImage.image =  UIImage(named: "bt_12")
        case 8:
            titleMessage.text = "got new house"
            bonusImage.image =  UIImage(named: "butt_5")
        default:
            titleMessage.text = "got new gift"
            bonusImage.image =  UIImage(named: "g_21")
        }
    }
    
    
    
    func continuePressed(_ sender: AnyObject) {
        self.delegate?.pressContinue()
    }
    
    
}
