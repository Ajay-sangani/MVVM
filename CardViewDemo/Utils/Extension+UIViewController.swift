//
//  Extension+UIViewController.swift
//  CardViewDemo
//
//  Created by Ajay Sangani on 2/21/19.
//  Copyright © 2019 Ajay Sangani. All rights reserved.
//

import UIKit
import Reachability
import FirebaseAuth

extension UIViewController {
  
  func alert(_ withMessage: String) {
    let alert = UIAlertController(title: "Error!", message: withMessage, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
    present(alert, animated: true, completion: nil)
  }
  
  func handleError(_ error: Error) {
    if let errorCode = AuthErrorCode(rawValue: error._code) {
      alert(errorCode.errorMessage)
    }
  }
}

extension AuthErrorCode {
  var errorMessage: String {
    switch self {
    case .emailAlreadyInUse:
      return "The email is already in use with another account"
    case .userNotFound:
      return "Account not found for the specified user. Please check and try again"
    case .userDisabled:
      return "Your account has been disabled. Please contact support."
    case .invalidEmail, .invalidSender, .invalidRecipientEmail:
      return "Please enter a valid email"
    case .networkError:
      return "Network error. Please try again."
    case .weakPassword:
      return "Your password is too weak. The password must be 6 characters long or more."
    case .wrongPassword:
      return "Your password is incorrect. Please try again or use 'Forgot password' to reset your password"
    default:
      return "Unknown error occurred"
    }
  }
}
