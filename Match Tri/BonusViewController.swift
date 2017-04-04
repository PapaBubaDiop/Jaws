//
//  BonusViewController.swift
//  Jaws 2
//
//  Created by vadim on 3/31/17.
//  Copyright © 2017 vadim. All rights reserved.
//

import UIKit

class BonusViewController: UIViewController {
    @IBOutlet weak var exitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func exitTapped(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    

}
