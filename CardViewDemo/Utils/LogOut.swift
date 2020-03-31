//
//  LogOut.swift
//  Latest Legal
//
//  Created by Ajay Sangani on 2/12/19.
//  Copyright © 2019 Ajay Sangani. All rights reserved.
//

import UIKit

class Switcher {
  
  static func updateRootVC(){
    
    let status = UserDefaults.standard.bool(forKey: "status")
    var rootVC : UIViewController?
    
    if(status == true){
      rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
    }else {      
      let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
      let nvc: UINavigationController = UINavigationController(rootViewController: controller)
      rootVC = nvc
    }
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.window?.rootViewController = rootVC
  }
  
}
