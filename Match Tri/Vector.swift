//
//  Vector.swift
//  Election Balls
//
//  Created by vadim on 10/12/16.
//  Copyright © 2016 Vadim Bashurov. All rights reserved.
//

import Foundation
import UIKit

struct Vector {
    var x:CGFloat = 0
    var y:CGFloat = 0
    
    
    mutating func copyVector(v:Vector) {
        x = v.x
        y = v.y
    }
    
    mutating func addVector(v:Vector) {
        x += v.x
        y += v.y
    }
    
    mutating func subVector(v:Vector) {
        x -= v.x
        y -= v.y
    }
    
    mutating func mulScalar(f: CGFloat) {
        x *= f
        y *= f
    }
    
    func magnitude()->CGFloat {
        return sqrt( x*x + y*y )
    }
    
    func magnitude2()->CGFloat {
        return  x*x + y*y
    }
    
    
    func getMulScalar(f: CGFloat)->Vector {
        let v = Vector(x:x*f, y:y*f)
        return v
    }
    
    func scalarProjectionOnto(v:Vector)->CGFloat {
        return (x * v.x + y * v.y) / v.magnitude()
    }
    
    
    func vectorProjectionOnto(v:Vector)->Vector {
        var res = v.getUnitVector()
        res.mulScalar( f: scalarProjectionOnto(v: v) )
        return res
    }
    
    func getUnitVector()->Vector {
        var len = magnitude()
        var res = Vector(x:x, y:y)
        if len>0 {
            len = 1.0/len;
            res.mulScalar(f:len)
        }
        return res
    }
    
    
    
    
}
   
