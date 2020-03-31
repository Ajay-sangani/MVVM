//
//  BaseViewController.swift
//  CardViewDemo
//
//  Created by Ajay Sangani on 2/21/19.
//  Copyright © 2019 Ajay Sangani. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
  var isNetworkReachable: Bool {
    return ReachabilityManager.shared.isNetworkReachable
  }
  var appDelegate: AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
  }
}
