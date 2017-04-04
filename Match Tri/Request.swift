//
//  Request.swift
//  Kremlins
//
//  Created by vadim on 9/27/16.
//  Copyright © 2016 Vadim Bashurov. All rights reserved.
//

import Foundation
import UIKit


protocol RequestDelegate {
    func updateTotalRank()
}



class Request {
    
    var delegate: RequestDelegate?
    
    let urlRoot = "http://www.you_site.org/jaws_request.php?"
    
    var points = 0
    var games = 0
    
    
    var rank:Int = 1000
    var total:Int = 1000
    var best:Int = 0
    var mode:Int = 0
    
    
    func loadPrefs()
    {
        let defaults = UserDefaults.standard
        points = defaults.integer(forKey: "points")
        games = defaults.integer(forKey: "games")
     }
    
    
    func savePrefs()
    {
        let defaults = UserDefaults.standard
        
        defaults.set(points, forKey: "points")
        defaults.set(games, forKey: "games")
  
        defaults.synchronize()
    }
  
    
    func keepScore(_ score:Int) {
        if score>points {
            points = score
            savePrefs()
        }
    }
    
    
    func saveScore(_ score:Int) {
        var pts = score
        
        if score>0 {
            if score>points {
                points = score
            }
            games += 1
            savePrefs()
        } else {
            pts = points
        }
        
        let u = UIDevice.current.identifierForVendor
        let udid =  u!.uuidString
        
        let name = UIDevice.current.name
        
        let tempAddress = "points=\(pts)&games=\(games)&udid=\(udid)&name=\(name)"
        
        print(tempAddress)
        
        let urlAddress = tempAddress.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        
        let url = URL(string: urlRoot+urlAddress!)
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!, completionHandler: { data, response, error in
            
            if data != nil {
                
                let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                if let words = dataString?.components(separatedBy: "<br>") {
                    if words.count>2 {
                        if let t = Int(words[0]) {
                            self.total = t
                        }
                        if let r = Int(words[1]) {
                            self.rank = r
                        }
                        if let b = Int(words[2]) {
                            self.best = b
                        }
                        print("total=\(self.total)  rank=\(self.rank)   best=\(self.best)")
                        OperationQueue.main.addOperation({
                            self.updateRank()
                        })
                        
                    }
                }
            }
        })
        
        task.resume()
        
    }
    
    func updateRank() {
        self.delegate?.updateTotalRank()
    }
}
