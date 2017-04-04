//
//  Obj.swift
//  Election Balls
//
//  Created by vadim on 10/11/16.
//  Copyright © 2016 Vadim Bashurov. All rights reserved.
//

import Foundation
import UIKit




class Obj {
    
    var up = [Int]()
    var down = [Int]()
    var food = [Int]()
    
    var nCol = 6
    var delay = 100
  
    
    var demo = [Int]()
    
    var speedLimit:Double = 12.0
    
    func initBoard(_ speed:Double) {
        
        speedLimit = speed
        
        up.removeAll()
        down.removeAll()
        food.removeAll()
        
        let k = 2
        
        for i in 0..<nCol {
            up.append(i==k ? 0 : 1)
            down.append(i==k ? 0 : 1)
            food.append(0)
        }
    }
    
    func findPath(bird iBird:Int, fruit iFruit:Int) {
        var dist = 10
        var h = 0
        
        demo.removeAll()
   
        let f = iFruit>=0 ? iFruit : 2
            
        
        for i in 0..<nCol {
            let a = up[i] + down[i]
            if a==0 {
                let d = i<f ? f-i : i-f
                if d<dist {
                    dist = d
                    h = i
                }
            }
        }
        
        
        if iFruit>=0 {
            
            if iFruit>iBird && iFruit<=h {
                demo.append(h-iBird)
                return
            }
            
            if iFruit<iBird && iFruit>=h {
                demo.append(h-iBird)
                return
            }
            
            demo.append(iFruit-iBird)
            if h != iFruit {
                demo.append(h-iFruit)
            }
        } else {
            demo.append(h-iBird)
        }
        
        
        
        
    }
    
   
    func setupDelay(_ ticks:Int) {
        let t = Double(ticks)
        let b:Double = 9000.0/2.2
        let c:Double = 100.0/2.2
        let d:Double = speedLimit + b/(c+t)
        delay = Int(d)
    }
    
    
   
    func defineJaws() {
        let k = Int(arc4random_uniform(UInt32(nCol)))
        for i in 0..<nCol {
            up[i] = i==k ? 0 : 1
            down[i] = i==k ? 0 : 1
        }
        
        
        for _ in 0..<2 {
            let k1 = Int(arc4random_uniform(UInt32(nCol)))
            let k2 = Int(arc4random_uniform(UInt32(nCol)))
            up[k1] = 0
            down[k2] = 0
        }
        
        
    }
    
}
