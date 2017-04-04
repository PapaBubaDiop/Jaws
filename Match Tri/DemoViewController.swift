//
//  DemoViewController.swift
//  Crash Mesh Saga
//
//  Created by vadim on 10/25/16.
//  Copyright © 2016 vadim. All rights reserved.
//

import UIKit

class DemoViewController: UIViewController {
    
    let fontName = "Troika"
    var timer: Timer! = nil
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var bird: UIImageView!
    
    @IBOutlet weak var alert: UIView!
    
    @IBOutlet weak var finger: UIImageView!
    
    var yBird:CGFloat = 325
    var xBird:CGFloat = 160
    var birdY:CGFloat = 315
    
    var yHand:CGFloat = 410
    
    var xMin:CGFloat = 40
    var xMax:CGFloat = 300
    
    var shift: CGFloat = 50
    
    
    var yUp = CGPoint()
    var yDown = CGPoint()
    var yGround = CGPoint()
    
    var iBird = 2
    var tBird = 0
    var sBird = 0
    
    
    @IBOutlet weak var fruit: UIImageView!
    
    var iFruit = 0
    var fruitFlag = 0
    
    
    @IBOutlet weak var upJaw: UIImageView!
    @IBOutlet weak var downJaw: UIImageView!
    @IBOutlet weak var bar: UIView!
    @IBOutlet weak var ground: UIImageView!
    
    var th = [16,6,1,0,4,14]
    
    var upTeeth = [UIImageView]()
    var downTeeth = [UIImageView]()
    var wTooth:CGFloat = 50
    let nTooth = 6
    
    var pause = 1
    
    var shutDelayTicks = 0
    var openDelayTicks = 0
    var score = 0
    var mode = 8
    var ticks = 20
 
    var dw:CGFloat = 40
    var upY:CGFloat = 75
    var downY:CGFloat = 55
    
    var obj = Obj()
    
    var food = [DebrisView]()
    let nFood = 7
    
    var drops = [FluffView]()
    let nDrops = 25
    
    var bubble = [BubbleView]()
    let nBubble = 6
    
    
    var fingerTick = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        obj.initBoard(12.0)
        setupDrops()
        renderScore()
        
    }
    
    
    func setupDrops()
    {
        let app = UIApplication.shared.delegate as! AppDelegate
        
        
        var images: [UIImage] = []
        images.append(UIImage(named: "hand_2")!)
        images.append(UIImage(named: "hand_1")!)
        
        finger.animationImages = images
        finger.animationDuration = 0.2
        finger.animationRepeatCount = 2
        
        ground.alpha = 0.5
        yUp = upJaw.center
        yDown = downJaw.center
        yGround = ground.center
        
        
        bird.alpha = 0
        
        
        if app.iPad==0 {
            
            let wDrops:CGFloat = 16
            
            if app.iPhone==0 {
                alert.center = CGPoint(x:160,y:240)
            } else {
                alert.center = CGPoint(x:160,y:alert.center.y)
            }
            
            alert.transform = CGAffineTransform(translationX: 0, y: 700)
            
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
            
            
            
            iFruit = 0
            fruitFlag = 0
            
            fruit.alpha = 0
            
            
            view.bringSubview(toFront: upJaw)
            view.bringSubview(toFront: downJaw)
            view.bringSubview(toFront: bar)
            view.bringSubview(toFront: finger)
            
            
            
            
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
            
            for k in 0..<nTooth {
                th[k] = (th[k]*3)/2
            }
            
            yHand = 600
            xMin = 320
            xMax = 770
            
            
            
            let wDrops:CGFloat = 32
            
            alert.center = CGPoint(x:512,y:alert.center.y)
            
            alert.transform = CGAffineTransform(translationX: 0, y: 768)
            view.bringSubview(toFront: bird)
            
            birdY = 465
            upY = 114
            downY = 78
        
            shift = 80
            wTooth = 75
            
            for k in 0..<nTooth {
                let xx:CGFloat = CGFloat(arc4random_uniform(20)) - 10
                let ww:CGFloat = CGFloat(arc4random_uniform(12))
                let x:CGFloat = setPosition(k) + xx
                let y:CGFloat = yUp.y - CGFloat(th[k]) + upY
                
                let img = UIImageView(image: UIImage(named:"b_14"))
                img.frame = CGRect(x: 0, y: 0, width: wTooth+ww, height: wTooth+5)
                
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
                img.frame = CGRect(x: 0, y: 0, width: wTooth+ww, height: wTooth+5)
                
                img.transform = CGAffineTransform(rotationAngle: 3.1415)
                img.center = CGPoint(x: x, y: y)
                downTeeth.append(img)
                view.addSubview(img)
            }
            
            
            
            iFruit = 0
            fruitFlag = 0
            
            fruit.alpha = 0
            
            
            view.bringSubview(toFront: upJaw)
            view.bringSubview(toFront: downJaw)
            view.bringSubview(toFront: bar)
            view.bringSubview(toFront: finger)
            
            
            
            
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
        
        mode = 8
        score = 0
        bird.alpha = 0
        
        restoreDrops()
        obj.initBoard(12.0)
        renderScore()
        
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
        } else {
            fruitFlag = 0
        }
        
    }
    
    func openJaws() {
        
        let r: CGFloat = shift
        
        if score>1 && pause<2 {
            addFruit()
        }
        
        if fruitFlag>0 {
            obj.findPath(bird: iBird, fruit: iFruit)
        } else {
            obj.findPath(bird: iBird, fruit: -1)
        }
        
        
        let a = obj.demo[0]
        
        var x:CGFloat = a>0 ? setPosition(iBird+a+1)+8 : setPosition(iBird+a-1)+28+20
        if x<xMin {
            x = xMin
        }
        if x>xMax {
            x = xMax
        }
        let y:CGFloat = yHand
        
        
        playSound(11)
        UIView.animate(withDuration: 0.5, delay: 0.0,  options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            self.bird.alpha = 1
            
            if a != 0 {
                self.finger.center = CGPoint(x: x, y: y)
            }
            
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
                        self.moveFinger()
        })
        
    }
    
    
    
    func moveFinger() {
        let a = obj.demo[0]
        let f = obj.demo.count
        
        if a != 0 {
            let x:CGFloat = finger.center.x + 2
            let y:CGFloat = finger.center.y + 2
            var del:Double = 0.1
            if a>0 {
                self.finger.animationRepeatCount = a
                self.finger.startAnimating()
                del = 0.1 * Double(a)
                
            } else if a<0 {
                self.finger.animationRepeatCount = -a
                self.finger.startAnimating()
                del = 0.1 * Double(-a)
            }
            UIView.animate(withDuration: 0.1, delay: del,  options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.finger.center = CGPoint(x: x, y: y)
            },
                           completion: {finished in
                            self.fingerTick = a
                            if f==1 {
                                self.fingerToRest(a)
                            } else {
                                self.moveFromFruit()
                            }
            })
        }
    }
    
    
    func moveFromFruit() {
        
        let a = obj.demo[1]
        
        var x:CGFloat = a>0 ? setPosition(iFruit+a+1)+8 : setPosition(iFruit+a-1)+28+20
        if x<xMin {
            x = xMin
        }
        if x>xMax {
            x = xMax
        }
        let y:CGFloat = yHand-5
        
        
        UIView.animate(withDuration: 0.3, delay: 0.1,  options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.finger.center = CGPoint(x: x, y: y)
        },
                       completion: {finished in
                        self.moveFinger2()
        })
    }
    
    
    
    func moveFinger2() {
        let a = obj.demo[1]
        if a>0 {
            self.finger.animationRepeatCount = a
            self.finger.startAnimating()
        } else if a<0 {
            self.finger.animationRepeatCount = -a
            self.finger.startAnimating()
        }
        fingerTick = a
        fingerToRest(a)
        
    }
    
    
    
    
    
    func fingerToRest(_ a:Int) {
        let x1:CGFloat = finger.center.x
        let y1:CGFloat = yHand+40
        UIView.animate(withDuration: 0.6, delay: 0,  options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.finger.center = CGPoint(x: x1, y: y1)
        },
                       completion: {finished in
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
            openDelayTicks = 75
        } else {
            score = score + 1
            ticks = ticks + 1
            renderScore()
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
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(DemoViewController.renderAlert), userInfo: nil, repeats: false)
    }
    
    
    func renderAlert() {
        
        view.bringSubview(toFront: alert)
        
        playSound(14)
        
        
        UIView.animate(withDuration: 0.25, delay: 2.0, options: .curveLinear, animations: {
            self.alert.transform = .identity
        },
                       completion: {finished in
        })
    }
    
    
    
    func renderScore()
    {
        scoreLabel.text = "\(score)"
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
        
        
        //        _ = navigationController?.popViewController(animated: true)
        
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
        
        timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector:#selector(PlayViewController.update), userInfo:nil, repeats: true)
    }
    
    func update()
    {
        let app = UIApplication.shared.delegate as! AppDelegate
        
        if app.pause {
            return
        }
        
        if pause<2 {
            if fingerTick>0 {
                fingerTick -= 1
                self.makeMove(1)
            }
            
            if fingerTick<0 {
                fingerTick += 1
                self.makeMove(-1)
            }
        }
        
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
                obj.defineJaws()
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
    
    
    
    
    func renderJumpBird() {
        var x:CGFloat = 0
        
        if fruitFlag>0 {
            if iFruit==iBird {
                playSound(6)
                animateBubbles()
                score += 1
                renderScore()
                fruitFlag = 0
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
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}










