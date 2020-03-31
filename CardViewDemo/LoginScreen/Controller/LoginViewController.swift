//
//  LoginViewController.swift
//  CardViewDemo
//
//  Created by Ajay Sangani on 2/21/19.
//  Copyright © 2019 Ajay Sangani. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
  
  @IBOutlet var userIdTextField: UITextField!
  @IBOutlet var passwordTextField: UITextField!
  
  private var viewModel = LoginViewModel()
  var activityIndicator = UIActivityIndicatorView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViewModel()
    userIdTextField.text = "test@gmail.com"
    passwordTextField.text = "123456"
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.navigationBar.isHidden = true
  }
  
  @IBAction func tappedLoginButton(_ sender: UIButton) {
    if isNetworkReachable {
      if !viewModel.isLoading {
        if let email = userIdTextField.text?.trim(), let password = passwordTextField.text?.trim() {
          if isValidate(email: email, password: password) {
            viewModel.login(email, password)
            updateUI()
          }
        }
      }
    } else {
      alert(StringResource.Errors.k_noInternet)
    }
  }
  
  func isValidate(email: String,password: String) -> Bool {
    if email.trim().isEmpty {
      alert(StringResource.Errors.k_emptyEmailAddress)
      return false
    } else if password.trim().isEmpty {
      alert(StringResource.Errors.k_emptyPassword)
      return false
    } else {
      return true
    }
  }
  
  private func setupViewModel() {
    viewModel.updatedOnLogin = { status, object, error in
      self.updateUI()
      switch status {
      case true:
        if let user = object {
          Utils.sharedInstance.setLoggedInUser()
          Utils.sharedInstance.setLoggedInUser(user: user)
          self.moveToScreen()
        }
      default:
        if let error = error {
          self.handleError(error)
        }
      }
    }
  }
}

extension LoginViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == userIdTextField {
      textField.resignFirstResponder()
      passwordTextField.becomeFirstResponder()
    } else {
      self.view.endEditing(true)
    }
    return false
  }
}


extension LoginViewController {
  
  func moveToScreen() {
    UserDefaults.standard.set(true, forKey: "status")
    Switcher.updateRootVC()
  }
  
  func showLoginFailedAlert() {
    let alert = UIAlertController(title: "Alert", message: "Wrong Email Address or Password.Let us know how can we help you?", preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: { action in
    }))
    alert.addAction(UIAlertAction(title: "Contacts us", style: UIAlertActionStyle.destructive, handler: { action in
      self.alert("Will Contact you soon")
    }))
    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
}

extension LoginViewController: ActivityIndicatorPresenter {
  // MARK: - Reset Title - Indicator View
  private func updateUI() {
    switch viewModel.isLoading {
    case true:
      showActivityIndicator()
    case false:
      hideActivityIndicator()
    }
  }
}
