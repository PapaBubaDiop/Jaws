//
//  GiftViewController.swift
//  Pipis
//
//  Created by Vadim Bashurov on 2/4/17.
//  Copyright © 2017 vadim. All rights reserved.
//

import UIKit

class GiftViewController: UIViewController {
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
  
    @IBAction func exitTapped(_ sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(GiftViewController.menuUpdate), userInfo: nil, repeats: false)
    }
    
    func menuUpdate() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let gifts = (app.requestLib.mode+1)/2
        if gifts>0 {
            renderBoxes(gifts)
        }
    }
    
    func renderBoxes(_ gifts:Int) {
 
        
        UIView.animate(withDuration: 0.25, delay: 1.0, options: .curveEaseIn, animations: {
            for i in 1...gifts {
                let box = self.view.viewWithTag(i+100) as! UIImageView!
                box?.transform = CGAffineTransform(rotationAngle: 4)
            }
        },
            completion: {finished in
                self.playSound(8)
                UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: .curveLinear, animations: {
                    for i in 1...gifts {
                        let box = self.view.viewWithTag(i+100) as! UIImageView!
                        box?.isHighlighted = true
                        box?.transform = .identity
                    }
                },
                               completion: {finished in
                                
                                
                })
                
        
        })
        
        
        
        
    }
    
    func playSound(_ trek:Int) {
        let app = UIApplication.shared.delegate as! AppDelegate
        app.playSound(trek)
    }
    
    
}
