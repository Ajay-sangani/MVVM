//
//  ReachabilityManager.swift
//  WoldyouRatherProduction
//
//  Created by Ajay Sangani on 7/4/18.
//  Copyright © 2018 Ajay Sangani. All rights reserved.
//

import Foundation
import Reachability

public protocol NetworkStatusListener : class {
  func networkStatusDidChange(status: Reachability.Connection)
}

class ReachabilityManager {
  
  static let shared = ReachabilityManager()
  let reachability = Reachability()!
  var reachabilityStatus: Reachability.Connection = .none
  var listeners = [NetworkStatusListener]()
  
  var isNetworkAvailable : Bool {
    return reachabilityStatus != .none
  }
  var isNetworkReachable: Bool {
    self.startMonitoring()
    return self.reachability.connection != .none || reachability.connection == .wifi || self.reachability.connection == .cellular
  }
  
  @objc func reachabilityChanged(notification: Notification) {
    
    let reachability = notification.object as! Reachability
    switch reachability.connection {
    case .none:
      break;
    case .wifi:
      break;
    case .cellular:
      break;
    }
    (UIApplication.shared.delegate as! AppDelegate).isNetworkAvailable =  !(reachability.connection == .none)
    
    for listener in listeners {
      listener.networkStatusDidChange(status: reachability.connection)
    }
  }
  
  func startMonitoring() {
    NotificationCenter.default.addObserver(self,selector: #selector(self.reachabilityChanged),name: Notification.Name.reachabilityChanged,object: reachability)
    do{
      try reachability.startNotifier()
    } catch {
      debugPrint("Could not start reachability notifier")
    }
  }
  
  func stopMonitoring(){
    reachability.stopNotifier()
    NotificationCenter.default.removeObserver(self,name: Notification.Name.reachabilityChanged,object: reachability)
  }
}

extension ReachabilityManager {
  
  func addListener(listener: NetworkStatusListener){
    listeners.append(listener)
  }
  
  func removeListener(listener: NetworkStatusListener){
    listeners = listeners.filter{ $0 !== listener}
  }
}
