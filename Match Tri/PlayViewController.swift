//
//  PlayViewController.swift
//  Match Tri
//
//  Created by vadim on 10/20/16.
//  Copyright © 2016 vadim. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {
    
    let fontName = "Troika"
    var timer: Timer! = nil
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var bird: UIImageView!
    
    
    var yBird:CGFloat = 325
    var xBird:CGFloat = 160
    var birdY:CGFloat = 315
    
    
    var dead = false
    
    var yUp = CGPoint()
    var yDown = CGPoint()
    var yGround = CGPoint()
    
    var iBird = 2
    var tBird = 0
    var sBird = 0
    
    
    @IBOutlet weak var fruit: UIImageView!
    
    var iFruit = 0
    var fruitFlag = 0
    var eatFruit = 0
    
    
    @IBOutlet weak var upJaw: UIImageView!
    @IBOutlet weak var downJaw: UIImageView!
    @IBOutlet weak var ground: UIImageView!
    @IBOutlet weak var bar: UIView!
    
    var th = [16,6,1,0,4,14]
    
    var upTeeth = [UIImageView]()
    var downTeeth = [UIImageView]()
    var wTooth:CGFloat = 50
    let nTooth = 6
    
    var pause = 1
    
    var shutDelayTicks = 0
    var openDelayTicks = 0
    var score = 0
    var tempScore = 0
    var ticks = 0
    var allFruitBonus = false
    var mode = 1
    
    var dw:CGFloat = 40
    var upY:CGFloat = 75
    var downY:CGFloat = 55
    var shift: CGFloat = 50
    
    var deltaTime:Double = 0.02
    
    var obj = Obj()
    
    
    var bonus = [UIImageView]()
    var splash = [UIImageView]()
    let nBonus = 16
    
    var eatItems = [UIImageView]()
    let nItems = 5
    
    
    var food = [DebrisView]()
    let nFood = 7
    
    var drops = [FluffView]()
    let nDrops = 25
    
    
    var bubble = [BubbleView]()
    let nBubble = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        obj.initBoard(14.0)
        setupDrops()
        
    }
    
    
    func setupDrops()
    {
        let app = UIApplication.shared.delegate as! AppDelegate
        
        
        yUp = upJaw.center
        yDown = downJaw.center
        yGround = ground.center
         
        bird.alpha = 0
        
        
        if app.iPad==0 {
            
            let wDrops:CGFloat = 16
        
            view.bringSubview(toFront: bird)
            
            for k in 0..<nTooth {
                let xx:CGFloat = CGFloat(arc4random_uniform(10)) - 5
                let ww:CGFloat = CGFloat(arc4random_uniform(6))
                let x:CGFloat = setPosition(k) + xx
                let y:CGFloat = yUp.y - CGFloat(th[k]) + upY
                
                let img = UIImageView(image: UIImage(named:"b_14"))
                img.frame = CGRect(x: 0, y: 0, width: wTooth+ww, height: wTooth+10)
                
                img.center = CGPoint(x: x, y: y)
                upTeeth.append(img)
                view.addSubview(img)
            }
            
            
            for k in 0..<nTooth {
                let xx:CGFloat = CGFloat(arc4random_uniform(10)) - 5
                let ww:CGFloat = CGFloat(arc4random_uniform(6))
                let x:CGFloat = setPosition(k) + xx
                let y:CGFloat = yDown.y - CGFloat(th[k]) - downY
                
                let img = UIImageView(image: UIImage(named:"b_15"))
                img.frame = CGRect(x: 0, y: 0, width: wTooth+ww, height: wTooth+10)
                
                img.transform = CGAffineTransform(rotationAngle: 3.1415)
                img.center = CGPoint(x: x, y: y)
                downTeeth.append(img)
                view.addSubview(img)
            }
            
            
           
            let rs:CGFloat = app.iPhone == 0 ? 0 : 30
            
            for k in 0..<nBonus {
                let ww:CGFloat = 32
                let x:CGFloat = CGFloat(k)*ww + ww/2
                let y:CGFloat = 495 + rs
                
                let img = UIImageView(image: UIImage(named:"g_\(k+2)"))
                img.frame = CGRect(x: 0, y: 0, width: ww, height: ww)
                img.center = CGPoint(x: x, y: y)
                bonus.append(img)
                view.addSubview(img)
            }
            
            
            for k in 0..<nBonus {
                let ww:CGFloat = 32
                let x:CGFloat = CGFloat(k)*ww + ww/2
                let y:CGFloat = 465 + rs
                
                let img = UIImageView(image: UIImage(named:"c_1"))
                img.frame = CGRect(x: 0, y: 0, width: 16, height: 23)
                img.center = CGPoint(x: x, y: y)
                img.isHidden = true
                splash.append(img)
                view.addSubview(img)
            }
            
            
            iFruit = 0
            fruitFlag = 0
            
            fruit.alpha = 0
            
            
            view.bringSubview(toFront: upJaw)
            view.bringSubview(toFront: downJaw)
            view.bringSubview(toFront: bar)
            
            
            for k in 0..<nItems {
                let ww:CGFloat = 24
                let x:CGFloat = CGFloat(k)*ww + ww*3.5
                let y:CGFloat = 28
                
                let img = UIImageView(image: UIImage(named:"g_2"))
                img.frame = CGRect(x: 0, y: 0, width: ww, height: ww)
                img.center = CGPoint(x: x, y: y)
                eatItems.append(img)
                view.addSubview(img)
            }
            
            
            let wFood:CGFloat = 16
            
            for _ in 0..<nFood {
                let dps = DebrisView(frame: CGRect(x: 0, y: 0, width: wFood, height: wFood))
                food.append(dps)
                view.addSubview(dps)
            }
            
            
            for _ in 0..<nBubble {
                let dps = BubbleView(frame: CGRect(x: 0, y: 0, width: wFood, height: wFood))
                bubble.append(dps)
                view.addSubview(dps)
            }
            
            
            for _ in 0..<nDrops {
                let dps = FluffView(frame: CGRect(x: 0, y: 0, width: wDrops, height: wDrops))
                drops.append(dps)
                view.addSubview(dps)
            }
            
            
        } else {
        
            let wDrops:CGFloat = 32
            for k in 0..<nTooth {
                th[k] = (th[k]*3)/2
            }
            
            
            view.bringSubview(toFront: bird)
            
            birdY = 465
            upY = 114
            downY = 78
        
            shift = 80
            wTooth = 75
            
            
            
            for k in 0..<nTooth {
                let xx:CGFloat = CGFloat(arc4random_uniform(20)) - 10
                let ww:CGFloat = CGFloat(arc4random_uniform(10))
                let x:CGFloat = setPosition(k) + xx
                let y:CGFloat = yUp.y - CGFloat(th[k]) + upY
                
                let img = UIImageView(image: UIImage(named:"b_14"))
                img.frame = CGRect(x: 0, y: 0, width: wTooth+ww, height: wTooth+8)
                
                img.center = CGPoint(x: x, y: y)
                upTeeth.append(img)
                view.addSubview(img)
            }
            
            
            for k in 0..<nTooth {
                let xx:CGFloat = CGFloat(arc4random_uniform(20)) - 10
                let ww:CGFloat = CGFloat(arc4random_uniform(12))
                let x:CGFloat = setPosition(k) + xx
                let y:CGFloat = yDown.y - CGFloat(th[k]) - downY
                
                let img = UIImageView(image: UIImage(named:"b_15"))
                img.frame = CGRect(x: 0, y: 0, width: wTooth+ww, height: wTooth+8)
                
                img.transform = CGAffineTransform(rotationAngle: 3.1415)
                img.center = CGPoint(x: x, y: y)
                downTeeth.append(img)
                view.addSubview(img)
            }
            
 
            
            
            
            
            for k in 0..<nBonus {
                let ww:CGFloat = 53
                let y:CGFloat = CGFloat(k)*ww + 108
                let x:CGFloat = 40
                
                let img = UIImageView(image: UIImage(named:"g_\(k+2)"))
                img.frame = CGRect(x: 0, y: 0, width: ww, height: ww)
                img.center = CGPoint(x: x, y: y)
                bonus.append(img)
                view.addSubview(img)
            }
            
            
            for k in 0..<nBonus {
                let ww:CGFloat = 53
                let y:CGFloat = CGFloat(k)*ww + 111
                let x:CGFloat = 95
                
                let img = UIImageView(image: UIImage(named:"c_1"))
                img.frame = CGRect(x: 0, y: 0, width: 30, height: 40)
                img.center = CGPoint(x: x, y: y)
                splash.append(img)
                view.addSubview(img)
            }
            
            
            iFruit = 0
            fruitFlag = 0
            
            fruit.alpha = 0
            
            
            view.bringSubview(toFront: upJaw)
            view.bringSubview(toFront: downJaw)
            view.bringSubview(toFront: bar)
            
            
            for k in 0..<nItems {
                let ww:CGFloat = 50
                let y:CGFloat = 400 - CGFloat(k)*(ww+14)
                let x:CGFloat = 870
                
                let img = UIImageView(image: UIImage(named:"g_2"))
                img.frame = CGRect(x: 0, y: 0, width: ww, height: ww)
                img.center = CGPoint(x: x, y: y)
                eatItems.append(img)
                view.addSubview(img)
            }
            
            
            let wFood:CGFloat = 32
            
            for _ in 0..<nFood {
                let dps = DebrisView(frame: CGRect(x: 0, y: 0, width: wFood, height: wFood))
                food.append(dps)
                view.addSubview(dps)
            }
            
            
            for _ in 0..<nBubble {
                let dps = BubbleView(frame: CGRect(x: 0, y: 0, width: wFood, height: wFood))
                bubble.append(dps)
                view.addSubview(dps)
            }
            
            
            for _ in 0..<nDrops {
                let dps = FluffView(frame: CGRect(x: 0, y: 0, width: wDrops, height: wDrops))
                drops.append(dps)
                view.addSubview(dps)
            }
            
        }
        
        
    }
    
    func hideItems() {
        for k in 0..<nItems {
            let img = eatItems[k]
            img.isHidden = true
        }
    }
    
    
    func renderItems() {
        for k in 0..<nItems {
            let img = eatItems[k]
            img.image = UIImage(named:"g_\(mode+1)")
            img.isHidden = k>=eatFruit ? false : true
            if score<2 {
                img.isHidden = true
            }
        }
    }
    
    func renderBonus() {
        for k in 0..<nBonus {
            let img = bonus[k]
            img.isHidden = k<mode-1 ? false : true
            if score<2 {
                img.isHidden = true
            }
            img.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
        }
        
        
        UIView.animate(withDuration: 0.65, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: .curveEaseOut, animations: {
            for k in 0..<self.nBonus {
                let img = self.bonus[k]
                img.transform = .identity
            }
        },
                       completion: {finished in
        })
        
    }
    
    func restoreDrops() {
        
        iFruit = 0
        fruitFlag = 0
        fruit.alpha = 0
        
        
        
        bird.image = UIImage(named: "bt_1")
        
        
        for k in 0..<nTooth {
            let img = upTeeth[k]
            let xx:CGFloat = CGFloat(arc4random_uniform(10)) - 5
            let x:CGFloat = setPosition(k) + xx
            let y:CGFloat = yUp.y - CGFloat(th[k]) + upY
            img.center = CGPoint(x: x, y: y)
        }
        
        
        for k in 0..<nTooth {
            let img = downTeeth[k]
            let xx:CGFloat = CGFloat(arc4random_uniform(10)) - 5
            let x:CGFloat = setPosition(k) + xx
            let y:CGFloat = yDown.y - CGFloat(th[k]) - downY
            img.center = CGPoint(x: x, y: y)
        }
        
        upJaw.center = yUp
        downJaw.center = yDown
        ground.center = yGround
        
    }
    
    
    func animateItem(_ k:Int) {
        
        let img = eatItems[k]
        
        for i in 0..<nFood {
            let b = food[i]
            b.center = CGPoint(x: b.x, y: b.y)
            b.boom(p: img.center, mode+1)
        }
        
    }
    
    
    
    
    
    func animateFood() {
        
        for i in 0..<nFood {
            let b = food[i]
            b.center = CGPoint(x: b.x, y: b.y)
            b.boom(p: fruit.center, fruitFlag)
        }
        
        fruit.alpha = 0
        
        //       Timer.scheduledTimer(timeInterval: 0.15, target: self, selector:#selector(PlayViewController.killBird), userInfo:nil, repeats: false)
        
    }
    
    
    func animateBubbles() {
        
        for i in 0..<nBubble {
            let b = bubble[i]
            b.center = CGPoint(x: b.x, y: b.y)
            b.boom(p: fruit.center)
        }
        
        fruit.alpha = 0
        
        //       Timer.scheduledTimer(timeInterval: 0.15, target: self, selector:#selector(PlayViewController.killBird), userInfo:nil, repeats: false)
        
    }
    
    
    
    
    
    func animateDrops() {
        
        for i in 0..<nDrops {
            let b = drops[i]
            b.center = CGPoint(x: b.x, y: b.y)
            b.boom(p: bird.center)
        }
        
        bird.image = UIImage(named: "bt_5")
        
        Timer.scheduledTimer(timeInterval: 0.15, target: self, selector:#selector(PlayViewController.killBird), userInfo:nil, repeats: false)
        
    }
    
    
    func  killBird() {
        playSound(2)
    }
    
    func newLevel() {
        
        mode = 1
        score = 0
        tempScore = 0
        ticks = 0
        allFruitBonus = true
        
        eatFruit = 0
        bird.alpha = 0
        
        restoreDrops()
        obj.initBoard(14.0)
        renderScore()
        renderBonus()
        renderItems()
        
        
        for k in 0..<nBonus {
            splash[k].isHidden = true
        }
        
        
        
        pause = 1
        
        Timer.scheduledTimer(timeInterval: 1.05, target: self, selector:#selector(PlayViewController.startPlay), userInfo:nil, repeats: false)
        
    }
    
    
    
    func startPlay() {
        
        openJaws()
        
        
        iBird = 2
        xBird = setPosition(iBird)
        yBird = birdY - CGFloat(th[iBird])
        tBird = 0
        sBird = 0
        bird.center = CGPoint(x: xBird, y: yBird)
        
        pause = 0
        
    }
    
    
    func addFruit() {
        let k = Int(arc4random_uniform(UInt32(nTooth)))
        
        if k != iBird {
            iFruit = k
            fruitFlag = 1 + mode
            fruit.image = UIImage(named:"g_\(fruitFlag)")
            
            let x = setPosition(iFruit)
            let y = birdY - CGFloat(th[iFruit])
            fruit.center = CGPoint(x: x, y: y)
            renderItems()
        } else {
            fruitFlag = 0
        }
        
    }
    
    func openJaws() {
        
        let r: CGFloat = shift
        
        if score>1 && pause<2 {
            addFruit()
        }
        
        playSound(11)
        UIView.animate(withDuration: 0.5, delay: 0.0,  options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            self.bird.alpha = 1
            
            if self.fruitFlag>0 {
                self.fruit.alpha = 1
            }
            
            for i in 0..<self.nTooth {
                let b = self.upTeeth[i]
                let up = self.obj.up[i]
                b.center = CGPoint(x: b.center.x, y: b.center.y-r)
                b.alpha = up == 0 ? 0 : 1
                let d = self.downTeeth[i]
                let down = self.obj.down[i]
                d.center = CGPoint(x: d.center.x, y: d.center.y+r)
                d.alpha = down == 0 ? 0 : 1
            }
            
            
            self.upJaw.center = CGPoint(x: self.yUp.x, y: self.yUp.y-r)
            
            self.downJaw.center = CGPoint(x: self.yDown.x, y: self.yDown.y+r)
            
        },
                       completion: {finished in
                        
                        self.setupShutDelay()
        })
        
    }
    
    
    func  checkKill()->Bool {
        let empty = obj.up[iBird] + obj.down[iBird]
        return empty==0 ? false : true
    }
    
    func setupShutDelay() {
        if pause==2 {
            saveMission()
        } else {
            obj.setupDelay(ticks)
            shutDelayTicks = obj.delay
        }
    }
    
    func setupOpenDelay() {
        if pause==2 {
            openDelayTicks = 105
        } else {
            score = score + 1
            ticks = ticks + 1
            pause = 1
            openDelayTicks = 4
        }
    }
    
    func shutJaws() {
        
        let r: CGFloat = -shift
        
        playSound(7)
        
        
        if checkKill() {
            tBird = 0
            pause = 2  // killed
            animateDrops()
        }
        
        if fruitFlag>0 {
            allFruitBonus = false
            animateFood()
            fruitFlag = 0
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            
            
            for i in 0..<self.nTooth {
                let b = self.upTeeth[i]
                b.center = CGPoint(x: b.center.x, y: b.center.y-r)
                let d = self.downTeeth[i]
                d.center = CGPoint(x: d.center.x, y: d.center.y+r)
            }
            
            
            self.upJaw.center = self.yUp
            
            self.downJaw.center = self.yDown
            
        },
                       completion: {finished in
                        self.setupOpenDelay()
        })
        
    }
    
    
    
    func setPosition(_ i:Int)->CGFloat {
        let app = UIApplication.shared.delegate as! AppDelegate
        return app.iPad==0 ? CGFloat(i)*wTooth + 35 : CGFloat(i)*wTooth + 324
    }
    
    
    
    func saveMission() {
        playSound(14)
        dead = true
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(PlayViewController.renderMenu), userInfo: nil, repeats: false)
    }
    
    
    func renderMenu() {
        let menu = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        menu.score = score
        self.navigationController?.pushViewController(menu, animated: true)
    }
    
    
    
    func renderScore()
    {
        if tempScore<score {
            tempScore += 1
            scoreLabel.text = "\(tempScore)"
        }
    }
    
    
    
    func showAds() {
        let app = UIApplication.shared.delegate as! AppDelegate
        app.showChartboostAds()
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first  {
            if pause == 0  {
                let pos = touch.location(in: view)
                if pos.x<bird.center.x - dw/5 {
                    makeMove(-1)
                } else if pos.x>bird.center.x + dw/5 {
                    makeMove(1)
                }
            }
        }
    }
    
    
    func makeMove(_ k:Int)
    {
        if k>0 {
            if iBird<5 {
                iBird += 1
                sBird = 2
                tBird = 1
                playSound(12)
            }
        } else {
            if iBird>0 {
                iBird -= 1
                sBird = 1
                tBird = 1
                playSound(12)
            }
        }
    }
    
    
    
    func checkEnd() {
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if dead {
            _ = navigationController?.popViewController(animated: true)
        }
        newLevel()
        
        startTimer()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func playSound(_ trek:Int) {
        let app = UIApplication.shared.delegate as! AppDelegate
        
        if trek>0 {
            app.playSound(trek)
        }
        
    }
    
    func startMusic()
    {
        let app = UIApplication.shared.delegate as! AppDelegate
        app.playSound(0)
        
    }
    
    
    func stopMusic()
    {
        let app = UIApplication.shared.delegate as! AppDelegate
        app.stopSounds()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopMusic()
        timer.invalidate()
        timer = nil
        
    }
    
    
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
        
        pause = 1
        openDelayTicks = 0
        shutDelayTicks = 0
        
        timer = Timer.scheduledTimer(timeInterval: deltaTime, target: self, selector:#selector(PlayViewController.update), userInfo:nil, repeats: true)
    }
    
    func update()
    {
        let app = UIApplication.shared.delegate as! AppDelegate
        
        
        
        if app.pause {
            return
        }
        
        renderScore()
        
        if tBird>0 {
            renderJumpBird()
            
            tBird += 1
            if tBird>9 {
                tBird = 0
                sBird = 0
            }
        }
        
        
        
        if shutDelayTicks>0 {
            shutDelayTicks -= 1
            if shutDelayTicks == 0 {
                shutJaws()
            }
        }
        
        if openDelayTicks>0 {
            openDelayTicks -= 1
            if openDelayTicks == 0 {
                if pause<2 {
                    obj.defineJaws()
                }
                openJaws()
                if pause==1 {
                    pause = 0
                }
            }
        }
        
        
        for i in 0..<nDrops {
            let b = drops[i]
            b.run()
            b.center = CGPoint(x: b.x, y: b.y)
        }
        
        for i in 0..<nFood {
            let b = food[i]
            b.run()
            b.center = CGPoint(x: b.x, y: b.y)
        }
        
        for i in 0..<nBubble {
            let b = bubble[i]
            b.run()
            b.center = CGPoint(x: b.x, y: b.y)
        }
        
        
    }
    
    
    func eatInc() {
        animateItem(eatFruit)
        eatFruit += 1
        if eatFruit>4 {
            if allFruitBonus {
                playSound(10)
                score += 25
                if mode<nBonus {
                    splash[mode-1].isHidden = false
                }
            } else {
                playSound(4)
            }
            
            allFruitBonus = true
            mode += 1
            eatFruit = 0
            renderBonus()
            hideItems()
        } else {
            renderItems()
        }
    }
    
    
    func renderJumpBird() {
        var x:CGFloat = 0
        
        if fruitFlag>0 {
            if iFruit==iBird {
                playSound(6)
                animateBubbles()
                score += fruitFlag
                fruitFlag = 0
                eatInc()
            }
        }
        
        
        
        xBird = setPosition(iBird)
        yBird = birdY - CGFloat(th[iBird])
        switch tBird {
        case 1:
            bird.image = UIImage(named: "bt_2")
            x = 35
        case 2:
            bird.image = UIImage(named: "bt_2")
            x = 30
        case 3:
            bird.image = UIImage(named: "bt_3")
            x = 25
        case 4:
            bird.image = UIImage(named: "bt_4")
            x = 20
        case 5:
            bird.image = UIImage(named: "bt_3")
            x = 15
        case 6:
            bird.image = UIImage(named: "bt_4")
            x = 10
        case 7:
            bird.image = UIImage(named: "bt_3")
            x = 5
        case 8:
            bird.image = UIImage(named: "bt_4")
            x = 0
        default:
            bird.image = UIImage(named: "bt_1")
        }
        if sBird==1 {
            x = -x
        }
        bird.center = CGPoint(x: xBird - x, y: yBird)
        
    }
    
    
    @IBAction func exitTapped(_ sender: AnyObject) {
        exitPlay()
    }
    
    func exitPlay()
    {
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}








