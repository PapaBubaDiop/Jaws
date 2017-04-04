//
//  PipeView.swift
//  Pipis
//
//  Created by Vadim Bashurov on 1/30/17.
//  Copyright © 2017 vadim. All rights reserved.
//

import UIKit

class PipeView: UIView {

    var faceImage: UIImageView!
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        faceImage = UIImageView(image: UIImage(named: "b_1"), highlightedImage:UIImage(named: "b_1"))
        faceImage.frame = frame
 
        self.addSubview(faceImage)
        
        return
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")
    }
    
    func setState(_ face: Int) {
   
        faceImage.alpha = 1
        
        
        switch face {
        case 1:
            faceImage.image = UIImage(named: "b_2")
            faceImage.highlightedImage = UIImage(named: "b_4")
            faceImage.transform = .identity
        case 2:
            faceImage.image = UIImage(named: "b_2")
            faceImage.highlightedImage = UIImage(named: "b_4")
            faceImage.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
        case 3:
            faceImage.image = UIImage(named: "b_3")
            faceImage.highlightedImage = UIImage(named: "b_5")
            faceImage.transform = .identity
        case 4:
            faceImage.image = UIImage(named: "b_3")
            faceImage.highlightedImage = UIImage(named: "b_5")
            faceImage.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
        case 5:
            faceImage.image = UIImage(named: "b_3")
            faceImage.highlightedImage = UIImage(named: "b_5")
            faceImage.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
        case 6:
            faceImage.image = UIImage(named: "b_3")
            faceImage.highlightedImage = UIImage(named: "b_5")
            faceImage.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
        default:
            faceImage.alpha = 0
        }
        
    }
    
    
}
