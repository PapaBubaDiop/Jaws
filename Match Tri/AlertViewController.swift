//
//  AlertViewController.swift
//  Cli Cli
//
//  Created by Vadim Bashurov on 10/8/16.
//  Copyright © 2016 Vadim Bashurov. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {

    @IBOutlet weak var trumpLabel: UILabel!
    @IBOutlet weak var clintonLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!

    @IBOutlet weak var ground: UIImageView!
    @IBOutlet weak var head: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let app = UIApplication.shared.delegate as! AppDelegate
        if app.iPhone5 == 0 {
            ground.frame = CGRect(x: 20,y: 12,width: 280,height: 408)
        }
        
        
        renderNums()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
     }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func renderNums() {
        let app = UIApplication.shared.delegate as! AppDelegate
        var t = 1
        var c = 1
        let v = 1

        
        if t<100 {
            trumpLabel.text = "\(t)¢"
        } else {
            t = t/100
            trumpLabel.text = "$\(t)"
        }
        
        if c<100 {
            clintonLabel.text = "\(c)¢"
        } else {
            c = c/100
            clintonLabel.text = "$\(c)"
        }
        
        
        
        if v>0 {
            head.isHidden = false
            let x:CGFloat = v==1 ? 50 : 200
            head.center = CGPoint(x:x, y:head.center.y)
            voteLabel.text = "You played for Me"
        } else {
            head.isHidden = true
            voteLabel.text = "Live Score"
        }
    }
    
    @IBAction func closeAlert(_ sender: AnyObject) {
        self.navigationController?.dismiss(animated: true, completion: {})
    }

}
