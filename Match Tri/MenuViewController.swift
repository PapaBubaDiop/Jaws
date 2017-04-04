//
//  MenuViewController.swift
//  Zabivaka
//
//  Created by vadim on 11/8/16.
//  Copyright © 2016 vadim. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bonusButton: UIButton!
    
    
    @IBOutlet weak var titleLogo: UILabel!
    @IBOutlet weak var totalLogo: UILabel!
    @IBOutlet weak var rankPlayer: UILabel!
    
    @IBOutlet weak var totalScore: UILabel!
    @IBOutlet weak var bestScore: UILabel!
    
    @IBOutlet weak var scroll: UIScrollView!
    
    let bonusScore = 500
    
    var rk = 1000
    var tt = 1000
    
    var score = 0
    var bonus = true
    
    var ticks1 = 0
    var ticks2 = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupButtons()
    }
    
    
    
    
    func setupButtons()
    {
        let app = UIApplication.shared.delegate as! AppDelegate
        
        if app.iPad == 0 {
            scroll.frame = CGRect(x: 0, y: 0, width: 320, height: app.iPhone==0 ? 480 : 568)
            scroll.contentSize = CGSize(width: 320, height: 568)
        }
        
        tt = app.requestLib.total
        rk = app.requestLib.rank
        
        
        let best = max(app.requestLib.points, app.requestLib.best)
        
        rankPlayer.text = "?/\(tt)"
        totalScore.text = "0"
        bestScore.text = "\(best)"
    }
    
    func menuUpdate() {
        renderMenu()
    }
    
    func renderMenu() {
        let dd = 30
        let sp = (score * ticks1) / dd
        
        totalScore.text = "\(sp)"
        if ticks1==5  {
            playSound(10)
        }
        if ticks1<dd {
            ticks1 += 1
            Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(MenuViewController.renderMenu), userInfo: nil, repeats: false)
        } else {
            rankPlayer.text = "\(rk)/\(tt)"
            
            renderBonus()
        }
    }
    
    func renderBonus() {
    
        if score>bonusScore {
            bonusButton.transform = CGAffineTransform(scaleX: 0.02, y: 0.02)
            bonusButton.isEnabled = true
            bonusButton.isHidden = false
            playSound(4)
            UIView.animate(withDuration: 1.05, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.0, options: .curveEaseOut, animations: {
       
                self.bonusButton.transform = .identity
            },
                completion: {finished in
            })
        }
    }
    
    func dropScore() {
        let app = UIApplication.shared.delegate as! AppDelegate
        tt = app.requestLib.total
        rk = app.requestLib.rank
        renderRank()
    }
    
    func renderRank() {
        let dd = 10
        
        let rr = 2 + arc4random_uniform(20)
        
        let st = (rk * ticks2) / dd
        rankPlayer.text = st>0 ? "\(st)/\(tt)" : "\(rr)/\(tt)"
        
        
        if ticks2<dd {
            ticks2 += 1
            Timer.scheduledTimer(timeInterval: 0.12, target: self, selector: #selector(MenuViewController.renderRank), userInfo: nil, repeats: false)
        }
    }
    
    
    
    
    
    func startAdMob() {
        let app = UIApplication.shared.delegate as! AppDelegate
        if app.requestLib.points<1000 {
            app.initAdMob()
        }
    //    app.showChartboostAds()
    }
    
   
    
    @IBAction func bonusTapped(_ sender: AnyObject) {
        bonus = false
    }
    
    
    
    @IBAction func exitTapped(_ sender: AnyObject) {
        startAdMob()
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    func playSound(_ trek:Int) {
        let app = UIApplication.shared.delegate as! AppDelegate
        app.playSound(trek)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        let app = UIApplication.shared.delegate as! AppDelegate
        
        topButton.isEnabled = app.requestLib.total>1000 ? true : false
        bonusButton.isHidden =  true
        
        let pts = score
        playSound(13)
        if bonus {
            app.requestLib.delegate = self
            app.requestLib.saveScore(pts)
            ticks1 = 0
            ticks2 = 0
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(MenuViewController.menuUpdate), userInfo: nil, repeats: false)
        }
    }
    
    
    func stopMusic()
    {
        let app = UIApplication.shared.delegate as! AppDelegate
        app.stopSounds()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ticks1 = 9
        ticks2 = 9
        stopMusic()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}



// MARK: - RequestDelegate
extension MenuViewController: RequestDelegate {
    
    func updateTotalRank() {
        dropScore()
    }
    
}


