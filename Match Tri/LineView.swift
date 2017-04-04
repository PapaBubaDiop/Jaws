//
//  LineView.swift
//  Election Balls
//
//  Created by Vadim Bashurov on 10/14/16.
//  Copyright © 2016 Vadim Bashurov. All rights reserved.
//

import UIKit

struct Drops {
    var status:Int = 0
    var ticks:Int = 0
    var indx:Int = 0
    var clr:Int = 0
    var tf:Int = 0
    var xc:CGFloat = 0
    var yc:CGFloat = 0
}


struct Falls {
    var status:Int = 0
    var ticks:Int = 0
    var clr:Int = 0
}



class LineView: UIView {

//    3598dc
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
        let obj = app.obj
        for t in obj.hulls  {
            renderSimple(t)
        }
        
          
        
        renderDrops()
        renderFalls()
        
     }
    
    
    func renderDrops()
    {
        let app = UIApplication.shared.delegate as! AppDelegate
        let obj = app.obj
        for j in obj.drops.indices {
            let d = obj.drops[j]
            if d.status==2 {
                let clr = d.clr
                let idx = d.indx-4
                let t2 = CGFloat(d.ticks - d.tf)
                let sc = t2 
                let a = CGFloat(0.25*sc)
                
                let dy = t2*t2*4.0
                let co = cos(a)
                let si = sin(a)
                let t = obj.hulls[idx]
                
                
                let path = UIBezierPath()
                let strokeColor = UIColor.black
                path.lineWidth = 1.0
                strokeColor.setStroke()
                
                let fillColor = d.ticks>=d.tf ? colors[clr] : colors[0]
                
                fillColor.setFill()
                var i = 0
                
                if d.ticks>=d.tf {
                    for p in t.vtx {
                        let x = d.xc + (p.x-d.xc)*co + (p.y-d.yc)*si
                        let y = d.yc + (p.y-d.yc)*co - (p.x-d.xc)*si
                        if i == 0 {
                            i = 1
                            path.move(to: CGPoint(x:x,y:y+dy))
                        } else {
                            path.addLine(to: CGPoint(x:x,y:y+dy))
                        }
                    }
                    path.fill()
                    
                } else {
                    for p in t.vtx {
                        if i == 0 {
                            i = 1
                            path.move(to: p)
                        } else {
                            path.addLine(to:p)
                        }
                    }
                    path.fill()
                }
  //              path.stroke()
            }
        }
    }
    
    
    
    
    func renderFalls()
    {
        let app = UIApplication.shared.delegate as! AppDelegate
        let obj = app.obj
        let sc = CGFloat(obj.fallFlag)
        let a = sc*0.33
        for j in obj.falls.indices {
            let d = obj.falls[j]
            if d.status>3 {
                let clr = d.clr
                let idx1 = j-4
                let idx2 = d.status-4
                let t1 = obj.hulls[idx1]
                let t2 = obj.hulls[idx2]
  //              print("obj.fallFlag = \(obj.fallFlag)")
                
                let path = UIBezierPath()
                let strokeColor = UIColor.black
                strokeColor.setStroke()
                let fillColor = colors[clr]
                fillColor.setFill()
                path.lineWidth = 1.0
                if t1.vtx.count>=t2.vtx.count {
                    for i in t1.vtx.indices {
                        let p1 = t1.vtx[i]
                        let k = i<t2.vtx.count ? i : t2.vtx.count-1
                        let p2 = t2.vtx[k]
                        
                        let x = p1.x*a + p2.x*(1-a)
                        let y = p1.y*a + p2.y*(1-a)
                        if i == 0 {
                            path.move(to: CGPoint(x:x,y:y))
                        } else {
                            path.addLine(to: CGPoint(x:x,y:y))
                        }
                    }
                } else {
                    for i in t2.vtx.indices {
                        let p2 = t2.vtx[i]
                        let k = i<t1.vtx.count ? i : t1.vtx.count-1
                        let p1 = t1.vtx[k]
                        
                        let x = p1.x*a + p2.x*(1-a)
                        let y = p1.y*a + p2.y*(1-a)
                        if i == 0 {
                            path.move(to: CGPoint(x:x,y:y))
                        } else {
                            path.addLine(to: CGPoint(x:x,y:y))
                        }
                    }
                    
                }
                path.fill()
                path.stroke()
                
            }
        }
    }
    
   
  
}
