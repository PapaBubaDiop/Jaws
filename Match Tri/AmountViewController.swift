//
//  AmountViewController.swift
//  pow2
//
//  Created by Vadim Bashurov on 3/28/16.
//  Copyright © 2016 Vadim Bashurov. All rights reserved.
//

import UIKit

class AmountViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var webView: UIWebView!
  
    let urlRoot = "http://www.your_site.org/jaws_news.php?"
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let app = UIApplication.shared.delegate as! AppDelegate
        
        
        if app.iPad == 0 && app.iPhone == 0 {
            webView.frame = CGRect(x: 0, y: 53, width: 320, height: 377)
        }
        
        webView.delegate = self
        loadUrl()
    
        
    }

    
    
    
    func loadUrl() {
        
        let jrand = arc4random_uniform(10000)
        let u = UIDevice.current.identifierForVendor
        let udid = u!.uuidString
        
        let tempAddress = "udid=\(udid)&jr=\(jrand)"
       
 //       let allowedCharacters = NSCharacterSet.URLPathAllowedCharacterSet()
        
 //       let urlAddress = tempAddress.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacters)
      
        let urlAddress = tempAddress.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
   
        let url = URL(string: urlRoot+urlAddress!)
        let requestObj = URLRequest(url: url!)
        webView.loadRequest(requestObj)
    }
    
   
    
    @IBAction func exitTapped(_ sender: AnyObject) {
        playSound(12)
        _ = self.navigationController?.popViewController(animated: true)
    }
    

    @IBAction func refreshTapped(_ sender: AnyObject) {
        playSound(3)
        loadUrl()
    }
    
    
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType)->Bool {
        
        print(" \(request) ")
        
        
        return true;
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("Webview started Loading")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("Webview did finish load")
        
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func playSound(_ trek:Int) {
        let app = UIApplication.shared.delegate as! AppDelegate
        app.playSound(trek)
    }
    
    
}
