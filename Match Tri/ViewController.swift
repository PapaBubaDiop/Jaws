//
//  ViewController.swift
//  Match Tri
//
//  Created by vadim on 10/20/16.
//  Copyright © 2016 vadim. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var ticks = 0
    var total = 1000
    var rank = 1000
    
    @IBOutlet weak var soundVolumeButton: UIImageView!
    @IBOutlet weak var face: UIImageView!
    
    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var barView: UIView!
    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var jawsLabel: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var topButton: UIButton!
    
    
    var xSound = CGFloat()
    var wSound = CGFloat()
    var soundVolume = 0.0
    var touchFlag = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVolumes()
        
        Timer.scheduledTimer(timeInterval: 0.15, target: self, selector: #selector(ViewController.animateControls), userInfo: nil, repeats: false)
    }
    
    
    
    func animateControls()
    {
        playSound(1)
        UIView.animate(withDuration: 0.95, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.barView.transform = .identity
        },
                       completion: {finished in
                        self.animateControls2()
        })
        
    }
    
    func animateControls2()
    {
        let app = UIApplication.shared.delegate as! AppDelegate
        UIView.animate(withDuration: 0.55, delay: 0.1, options: UIViewAnimationOptions.curveLinear, animations: {
            self.jawsLabel.alpha = app.iPad==0 ? 0.0 : 0.9
        },
                       completion: {finished in
                        self.animateNextControls()
        })
        
    }
    
    
    func animateNextControls()
    {
        playSound(8)
        UIView.animate(withDuration: 0.55, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.logoView.transform = .identity
            self.soundVolumeButton.transform = .identity
            self.playButton.transform = .identity
            
        },
                       completion: {finished in
                        self.face.startAnimating()
                        //               self.playSound(12)
        })
    }
    
    
    
    func setupVolumes()
    {
        let app = UIApplication.shared.delegate as! AppDelegate
        let defaults = UserDefaults.standard
        soundVolume = defaults.double(forKey: "soundVolume")
        let run = defaults.integer(forKey: "run200")
        if run == 0 {
            soundVolume = 0.0
            defaults.set(soundVolume, forKey: "soundVolume")
            defaults.set(1, forKey: "run200")
            defaults.synchronize()
        }
        
        if app.iPad == 1 {
            
            barView.center = CGPoint(x: 512, y: 700)
            
            xSound = 900
            wSound = 70
            
            soundVolumeButton.center = CGPoint(x: xSound - wSound + wSound * CGFloat(2.0*soundVolume),  y: soundVolumeButton.center.y)
            app.setSoundVolume(soundVolume)
            
            logoView.transform = CGAffineTransform(translationX: -1024, y: 0)
            barView.transform = CGAffineTransform(translationX: 0, y: 300)
            playButton.transform = CGAffineTransform(translationX: 0, y: 850)
            
        } else {
            
            if app.iPhone==0 {
                face.center = CGPoint(x: 160, y: 187)
                playButton.center = CGPoint(x: 160, y: 295)
                jawsLabel.center = CGPoint(x: 160, y: 295)
                
                barView.center = CGPoint(x: 160, y: 440)
            } else {
                barView.center = CGPoint(x: 160, y: 540)
            }
            
            xSound = 255
            wSound = 40
            
            soundVolumeButton.center = CGPoint(x: xSound - wSound + wSound * CGFloat(2.0*soundVolume),  y: soundVolumeButton.center.y)
            app.setSoundVolume(soundVolume)
            
            logoView.transform = CGAffineTransform(translationX: -320, y: 0)
            barView.transform = CGAffineTransform(translationX: 0, y: 150)
            soundVolumeButton.transform = CGAffineTransform(translationX: 200, y: 0)
            playButton.transform = CGAffineTransform(translationX: 0, y: 500)
        }
        
        
        var images: [UIImage] = []
        images.append(UIImage(named: "b_20")!)
        images.append(UIImage(named: "b_21")!)
        
        face.animationImages = images
        face.animationDuration = 0.18
        face.animationRepeatCount = 2
        
        
    }
    
    func showAds() {
        let app = UIApplication.shared.delegate as! AppDelegate
        app.showChartboostAds()
    }
    
    @IBAction func adsTapped(_ sender: AnyObject) {
        showAds()
    }
    
    @IBAction func pzlDemoTapped(_ sender: AnyObject) {
        playSound(8)
        
        let demoViewController = self.storyboard?.instantiateViewController(withIdentifier: "DemoViewController") as! DemoViewController
        self.navigationController?.pushViewController(demoViewController, animated: true)
    }
    
    
    
    @IBAction func pzlPlayTapped(_ sender: AnyObject) {
        playSound(5)
        let play = self.storyboard?.instantiateViewController(withIdentifier: "PlayViewController") as! PlayViewController
        self.navigationController?.pushViewController(play, animated: true)
    }
    
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first  {
            if touch.view!.tag == 100  {
                touchFlag = 1
            } else {
                touchFlag = 0
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first  {
            let pos = touch.location(in: view)
            if  touch.view!.tag == 100  && touchFlag == 1  {
                var x = pos.x
                if x > xSound + wSound {
                    x = xSound  + wSound
                }
                if x < xSound - wSound {
                    x = xSound  - wSound
                }
                updateSoundVolume(x:x)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touchFlag == 1 {
            let defaults = UserDefaults.standard
            defaults.set(soundVolume, forKey: "soundVolume")
            playSound(1)
        }
        touchFlag = 0
    }
    
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchFlag = 0
    }
    
    
    func playSound(_ trek:Int) {
        let app = UIApplication.shared.delegate as! AppDelegate
        app.playSound(trek)
    }
    
    func updateSoundVolume(x:CGFloat) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        soundVolume = Double( (x - xSound + wSound )/(2*wSound) )
        soundVolumeButton.center = CGPoint( x: CGFloat(x) ,  y: soundVolumeButton.center.y)
        appDelegate.setSoundVolume(soundVolume)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopMusic()
        ticks = 9
    }
    
    func stopMusic()
    {
        let app = UIApplication.shared.delegate as! AppDelegate
        app.stopSounds()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        startTimer()
    }
    
    
    func dropScore() {
        let app = UIApplication.shared.delegate as! AppDelegate
        
        ticks = 0
        total = app.requestLib.total
        rank = app.requestLib.rank
        rankLabel.text = "?/\(total)"
        renderDropScore()
        
    }
    
    func renderDropScore() {
        
        let dd = 10
        let sr = (rank * ticks) / dd
        
        let rr = 2 + arc4random_uniform(20)
        
        rankLabel.text = sr>0 ? "\(sr)/\(total)" : "\(rr)/\(total)"
        
        if ticks==2  {
            playSound(10)
        }
        
        if ticks<dd {
            ticks += 1
            Timer.scheduledTimer(timeInterval: 0.12, target: self, selector: #selector(ViewController.renderDropScore), userInfo: nil, repeats: false)
        } else {
            rankLabel.text = "\(rank)/\(total)"
        }
    }
    
    
    
    func startTimer() {
        
        let app = UIApplication.shared.delegate as! AppDelegate
        
        topButton.isEnabled = app.requestLib.total>1000 ? true : false
        
        app.requestLib.delegate = self
        app.updateRank()
        
        if app.GADFlag>0 {
            if app.iPad==0 {
                if app.iPhone==0 {
                    barView.center = CGPoint(x: 160, y: 440-50)
                } else {
                    barView.center = CGPoint(x: 160, y: 540-50)
                }
            } else {
                barView.center = CGPoint(x: 512, y: 768-150)
            }
        }
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


// MARK: - RequestDelegate
extension ViewController: RequestDelegate {
    
    func updateTotalRank() {
        dropScore()
    }
    
}

