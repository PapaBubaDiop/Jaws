//
//  ShopViewController.swift
//  Pipis
//
//  Created by vadim on 2/3/17.
//  Copyright © 2017 vadim. All rights reserved.
//

import UIKit
import StoreKit

class ShopViewController: UIViewController {
    @IBOutlet weak var wait: UIView!
    @IBOutlet weak var waitBar: UIImageView!
    @IBOutlet weak var waitLogo: UILabel!
  
    @IBOutlet weak var livesLabel: UILabel!
    
    var product_id: String?
    
    var boughtLives = 0
    var ticks = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        let app = UIApplication.shared.delegate as! AppDelegate
        var ff: [UIImage] = []
        ff.append(UIImage(named: "b_8")!)
        ff.append(UIImage(named: "b_7")!)
        ff.append(UIImage(named: "b_6")!)
        ff.append(UIImage(named: "b_5")!)
        ff.append(UIImage(named: "b_6")!)
        ff.append(UIImage(named: "b_7")!)
        ff.append(UIImage(named: "b_8")!)
        
        waitBar.animationImages = ff
        waitBar.animationRepeatCount = 0
        waitBar.animationDuration = 1.5
     
        wait.isHidden = true
       
        
        if app.iPad==0 {
            wait.center = CGPoint(x:160,y:wait.center.y)
        } else {
            wait.center = CGPoint(x:512,y:wait.center.y)
        }
        
        SKPaymentQueue.default().add(self)

        let lvs = app.requestLib.lives
        livesLabel.text = lvs==0 ? "Have no lives" : lvs==1 ? "Have 1 life" : "Have \(lvs) lives"
        
    }
    
    
    
    func renderLives() {
        let app = UIApplication.shared.delegate as! AppDelegate
        
        let dd = 10
        let delta = boughtLives
        let old = app.requestLib.lives - delta
        let lvs = old + (delta * ticks) / dd
        livesLabel.text = lvs==0 ? "Have no lives" : lvs==1 ? "Have 1 life" : "Have \(lvs) lives"
        
        if ticks==2 {
            app.playSound(10)
        }
        
        if ticks<dd {
            ticks += 1
            Timer.scheduledTimer(timeInterval: 0.12, target: self, selector: #selector(ShopViewController.renderLives), userInfo: nil, repeats: false)
        } else {
            let l = app.requestLib.lives
            livesLabel.text = "Have \(l) lives"
        }
        
    }
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func exitTapped(_ sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pressBuy5(_ sender: AnyObject) {
        let app = UIApplication.shared.delegate as! AppDelegate
        switch app.appName {
        case .jaws2017:
            product_id = "com.bashni.jaws2017.buy100"
        case .jaws2:
            product_id = "com.bashni.jaws2017.buy100"
        }
        
        startWait()
        
        boughtLives = 100
        // Can make payments
        if (SKPaymentQueue.canMakePayments())
        {
            let productID:NSSet = NSSet(object: self.product_id!);
            let productsRequest:SKProductsRequest = SKProductsRequest(productIdentifiers: productID as! Set<String>);
            productsRequest.delegate = self;
            productsRequest.start();
            print("Fetching Products");
        }else{
            print("Can't make purchases")
            stopWait("Can't make purchases")
        }

    }
    
    @IBAction func pressBuy50(_ sender: AnyObject) {
        let app = UIApplication.shared.delegate as! AppDelegate
        switch app.appName {
        case .jaws2017:
            product_id = "com.bashni.jaws2017.buy500"
        case .jaws2:
            product_id = "com.bashni.jaws2017.buy500"
        }
        startWait()
    
        boughtLives = 500
        
        // Can make payments
        if (SKPaymentQueue.canMakePayments())
        {
            let productID:NSSet = NSSet(object: self.product_id!);
            let productsRequest:SKProductsRequest = SKProductsRequest(productIdentifiers: productID as! Set<String>);
            productsRequest.delegate = self;
            productsRequest.start();
            print("Fetching Products");
        }else{
            print("Can't make purchases");
            stopWait("Can't make purchases")
        }

    
    
    }
    
    func buyProduct(product: SKProduct){
        print("Sending the Payment Request to Apple")
        
        waitLogo.text = "Sending the Payment Request"
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment);
        
    }
 
    
    func startWait() {
        wait.isHidden = false
        wait.alpha = 0
        waitLogo.text = "Wait.."
        
        UIView.animate(withDuration: 0.65, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.wait.alpha = 1
            
        },
            completion: {finished in
                self.waitBar.startAnimating()
                        
        })
        
    }
   
    func stopWait(_ msg:String) {
  
        waitLogo.text = msg
        waitBar.stopAnimating()
        UIView.animate(withDuration: 0.35, delay: 2.0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.wait.alpha = 0
        },
                       completion: {finished in
                        self.wait.isHidden = true
        })
        
        
        
    }
    
}

extension ShopViewController: SKProductsRequestDelegate, SKPaymentTransactionObserver {
    func productsRequest (_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        let count : Int = response.products.count
        
        print("response.products.count = \(count)")
        
        if (count>0) {
            let validProduct: SKProduct = response.products[0] as SKProduct
            if (validProduct.productIdentifier == self.product_id) {
                print(validProduct.localizedTitle)
                let s:String = validProduct.localizedTitle
                OperationQueue.main.addOperation({
                    self.waitLogo.text = s
                })
                print(validProduct.localizedDescription)
                print(validProduct.price)
                buyProduct(product: validProduct);
            } else {
                print(validProduct.productIdentifier)
            }
        } else {
            print("nothing")
        }
    }
    
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        stopWait("Error Fetching")
        print("Error Fetching product information");
    }
    
    func paymentQueue(_ queue: SKPaymentQueue,
                      updatedTransactions transactions: [SKPaymentTransaction])
        
    {
        let app = UIApplication.shared.delegate as! AppDelegate
        print("Received Payment Transaction Response from Apple");
        stopWait("Received Payment")
        

        for transaction:AnyObject in transactions {
            if let trans:SKPaymentTransaction = transaction as? SKPaymentTransaction{
                switch trans.transactionState {
                case .purchased:
                    print("Product Purchased");
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    // Handle the purchase
                    UserDefaults.standard.set(true , forKey: "purchased")
                
                    app.playSound(10)
                    app.requestLib.addLives(boughtLives)
                    stopWait("Perfect. You got it")
                    renderLives()
                    break;
                case .failed:
                    print("Purchased Failed");
                    stopWait("Purchased Failed")
      
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    break;
                    
                    
                    
                case .restored:
                    print("Already Purchased");
                    SKPaymentQueue.default().restoreCompletedTransactions()
                    
                    
                    // Handle the purchase
                    UserDefaults.standard.set(true , forKey: "purchased")
                    //adView.hidden = true
                    break;
                default:
                    break;
                }
            }
        }
        
    }
}


