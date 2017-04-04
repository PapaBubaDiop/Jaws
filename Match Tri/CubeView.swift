//
//  CubeView.swift
//  Doodle Сock
//
//  Created by Vadim Bashurov on 2/5/17.
//  Copyright © 2017 vadim. All rights reserved.
//

import UIKit

class CubeView: UIView {

    var faceImage: UIImageView!
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        faceImage = UIImageView(image: UIImage(named: "b_1"))
        faceImage.frame = frame
        
        self.addSubview(faceImage)
        
        return
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")
    }
    
    func setState(_ face: Int) {
        
        faceImage.image = UIImage(named: "b_\(face)")
        
    }
    
    
}
