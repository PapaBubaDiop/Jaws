//
//  PlayAlertView.swift
//  halves2048
//
//  Created by vadim on 1/18/17.
//  Copyright © 2017 vadim. All rights reserved.
//

import UIKit


protocol PlayAlertViewDelegate {
    func pressPlay()
    func pressReplay()
    func pressExit()
    func pressAds()
    func pressTop()
}

class PlayAlertView: UIView {
    
    var delegate: PlayAlertViewDelegate?
    
    var titleMessage: UILabel!
    
    var msg1: UILabel!
    var msg2: UILabel!
 
    
    let fontName = "Troika"
    
    var lImage: UIImageView!
    var cImage: UIImageView!
    var rImage: UIImageView!
    var b: UIButton!
    var exit: UIButton!
    
    var ads: UIButton!
    var top: UIButton!
    
    
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 320, height: 568) )
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
 
 
        
        let ground = UIImageView(image: UIImage(named: "g_9"))
        ground.frame = CGRect(x: 0,y: -24,width: 320,height: 568)
        
        self.addSubview(ground)
        
        
        let w:CGFloat = 29
 
        let m = UIImageView(image: UIImage(named: "g_24"))
        m.frame = CGRect(x: 82,y: 230,width: w,height: w)
        self.addSubview(m)
        
        let t = UIImageView(image: UIImage(named: "g_22"))
        t.frame = CGRect(x: 82,y: 265,width: w,height: w)
        self.addSubview(t)
        
        
        lImage = UIImageView(image: UIImage(named: "g_17"))
        lImage.frame = CGRect(x: 0,y: 0,width: 80,height: 80)
        lImage.center = CGPoint(x: 160-58, y: 160+18)
        
        rImage = UIImageView(image: UIImage(named: "g_17"))
        rImage.frame = CGRect(x: 0,y: 0,width: 80,height: 80)
        rImage.center = CGPoint(x: 160+60, y: 160+18)
        
        cImage = UIImageView(image: UIImage(named: "g_17"))
        cImage.frame = CGRect(x: 0,y: 0,width: 103,height: 103)
        cImage.center = CGPoint(x: 160, y: 160)
        
        lImage.alpha = 0.75
        rImage.alpha = 0.75
        cImage.alpha = 0.75
        
        
        
        b = UIButton(frame: CGRect(x: 0,y: 0,width: 80, height: 80))
        b.setBackgroundImage(UIImage(named: "bt_6"), for: UIControlState())
        b.center = CGPoint(x: 160, y: 425)
 
        
        exit = UIButton(frame: CGRect(x: 0,y: 0,width: 57, height: 57))
        exit.setBackgroundImage(UIImage(named: "bt_5"), for: UIControlState())
        exit.center = CGPoint(x: 288, y: 72)
        

        ads = UIButton(frame: CGRect(x: 0,y: 0,width: 37, height: 48))
        ads.setBackgroundImage(UIImage(named: "g_16"), for: UIControlState())
        ads.center = CGPoint(x: 160+75, y: 426)
 
        top = UIButton(frame: CGRect(x: 0,y: 0,width: 57, height: 37))
        top.setBackgroundImage(UIImage(named: "g_29"), for: UIControlState())
        top.center = CGPoint(x: 160-75, y: 426)
        
        
        titleMessage = UILabel(frame: CGRect(x: 0,y: 0,width: 240, height: 41))
        titleMessage.font = UIFont(name: fontName, size: 27)
        titleMessage.center = CGPoint(x: 160, y: 64)
        titleMessage.text = "Target"
        titleMessage.textColor = UIColor.yellow
        titleMessage.textAlignment = .center
        self.addSubview(titleMessage)
        
        
        msg1 = UILabel(frame: CGRect(x: 0,y: 0,width: 200, height: 21))
        msg1.font = UIFont(name: fontName, size: 21)
        msg1.center = CGPoint(x: 220, y: 245)
        msg1.text = "msg 1"
        msg1.textColor = UIColor.white
        msg1.textAlignment = .left
        self.addSubview(msg1)
        
        
        msg2 = UILabel(frame: CGRect(x: 0,y: 0,width: 200, height: 21))
        msg2.font = UIFont(name: fontName, size: 21)
        msg2.center = CGPoint(x: 220, y: 280)
        msg2.text = "msg 2"
        msg2.textColor = UIColor.white
        msg2.textAlignment = .left
        self.addSubview(msg2)
        
        self.addSubview(top)
        self.addSubview(ads)
        self.addSubview(b)
        self.addSubview(exit)
        self.addSubview(lImage)
        self.addSubview(rImage)
        self.addSubview(cImage)
        
        exit.addTarget(self, action: #selector(PlayAlertView.exitPressed(_:)), for: .touchUpInside)
        
        top.addTarget(self, action: #selector(PlayAlertView.topPressed(_:)), for: .touchUpInside)
        ads.addTarget(self, action: #selector(PlayAlertView.adsPressed(_:)), for: .touchUpInside)
        
        
        return
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")
    }
    
    
    func prepareToMission(_ lvl:Int, score:Int, best:Int) {
        
        b.removeTarget(nil, action: nil, for: .allEvents)
        b.addTarget(self, action: #selector(PlayAlertView.playPressed(_:)), for: .touchUpInside)
        
        titleMessage.text = "Level #\(lvl)"
        msg1.text = "Best \(best) "
        msg2.text = "\(score) Moves"
        
        rImage.isHidden = true
        lImage.isHidden = true
        cImage.isHidden = true
        
   //     exit.isHidden = true
        b.isHidden = false
        
        b.setBackgroundImage(UIImage(named: "butt_8"), for: UIControlState())
        
    }

    
    func prepareToDrops(lives:Int, best:Int) {
        
        b.removeTarget(nil, action: nil, for: .allEvents)
        b.addTarget(self, action: #selector(PlayAlertView.playPressed(_:)), for: .touchUpInside)
        
        titleMessage.text = "Keep the score"
        msg1.text = "Best \(best)"
        msg2.text = "Lives \(lives)"
        
        rImage.isHidden = true
        lImage.isHidden = true
        cImage.isHidden = true
        
   //     exit.isHidden = true
        b.isHidden = false
        b.setBackgroundImage(UIImage(named: "butt_8"), for: UIControlState())
    }
    

    func prepareToScore(score:Int, stars:Int) {
  
        b.removeTarget(nil, action: nil, for: .allEvents)
        b.addTarget(self, action: #selector(PlayAlertView.replayPressed(_:)), for: .touchUpInside)
        
        
        titleMessage.text = stars>0 ? "level up" : "Play well"
        
        msg1.text = stars>0 ? "\(score) golds" : "No golds"
        msg2.text = stars>0 ? "Excellent" : "No stars"
       
        
        exit.isHidden = false
        b.isHidden = false
  
        rImage.isHidden = stars>2 ? false : true
        lImage.isHidden = stars>1 ? false : true
        cImage.isHidden = stars>0 ? false : true
        if score>0 {
            b.setBackgroundImage(UIImage(named: "butt_8"), for: UIControlState())
        } else {
            b.setBackgroundImage(UIImage(named: "bt_6"), for: UIControlState())
        }
    }
  
    
     
    func prepareToScoreDrops(bonus:Bool, stars:Int, score:Int, best:Int) {
        
        b.removeTarget(nil, action: nil, for: .allEvents)
        b.addTarget(self, action: #selector(PlayAlertView.replayPressed(_:)), for: .touchUpInside)
        
        
        
        if bonus {
            titleMessage.text = "personal best"
        } else {
            switch stars {
            case 0:
                titleMessage.text = "dummy game"
            case 1:
                titleMessage.text = "nice game"
            case 2:
                titleMessage.text = "good game"
            case 3:
                titleMessage.text = "well done"
            case 4:
                titleMessage.text = "great job"
            case 5:
                titleMessage.text = "excellent"
            case 6:
                titleMessage.text = "incredible"
            case 7:
                titleMessage.text = "amazing"
            default:
                titleMessage.text = "impossible"
            }
            
        }
        
        
        msg1.text = "best: \(best)"
        msg2.text = "your: \(score)"
        
        exit.isHidden = false
        b.isHidden = false
        
        rImage.isHidden = stars>5 ? false : true
        lImage.isHidden = stars>2 ? false : true
        cImage.isHidden = stars>0 ? false : true
        
        b.setBackgroundImage(UIImage(named: "bt_6"), for: UIControlState())
    }
    
    
    
    
    func prepareToFail() {
        b.removeTarget(nil, action: nil, for: .allEvents)
        b.addTarget(self, action: #selector(PlayAlertView.replayPressed(_:)), for: .touchUpInside)
        
        
        
        titleMessage.text = "Missed level"
        
        msg1.text = "No Golds"
        msg2.text = "Moves over"
        
        exit.isHidden = false
        b.isHidden = false
        
        rImage.isHidden = true
        lImage.isHidden = true
        cImage.isHidden = true
        
        b.setBackgroundImage(UIImage(named: "bt_6"), for: UIControlState())
    }
    
    
    func prepareToFailDrops(lives:Int) {
        b.removeTarget(nil, action: nil, for: .allEvents)
        b.addTarget(self, action: #selector(PlayAlertView.replayPressed(_:)), for: .touchUpInside)
        
        titleMessage.text = "Failed game"
        
        msg1.text = "Lives \(lives)"
        msg2.text = "No goods"
        
        exit.isHidden = false
        b.isHidden = false
        
        rImage.isHidden = true
        lImage.isHidden = true
        cImage.isHidden = true
        
        b.setBackgroundImage(UIImage(named: "butt_8"), for: UIControlState())
    }
    
    
    
    
    func replayPressed(_ sender: AnyObject) {
        self.delegate?.pressReplay()
    }

    func playPressed(_ sender: AnyObject) {
        self.delegate?.pressPlay()
    }
    
    func exitPressed(_ sender: AnyObject) {
        self.delegate?.pressExit()
    }
    
    func topPressed(_ sender: AnyObject) {
        self.delegate?.pressTop()
    }
    
    func adsPressed(_ sender: AnyObject) {
        self.delegate?.pressAds()
    }

    
    
}
