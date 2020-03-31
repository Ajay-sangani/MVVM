//
//  ViewController.swift
//  CardViewDemo
//
//  Created by Ajay Sangani on 11/14/17.
//  Copyright © 2017 Ajay Sangani. All rights reserved.
//

import UIKit
import ZLSwipeableView
import SDWebImage

class ViewController: BaseViewController ,ZLSwipeableViewDelegate, ZLSwipeableViewDataSource {
  
  @IBOutlet weak var cardView: ZLSwipeableView!
  @IBOutlet var layerView : UIView!
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var descriptionLabel: UILabel!
  
  var detail = [Detail]()
  fileprivate let repository = CategoriesRepository()
  
  var colorIndex: Int = 0
  var cardSwipedAt = 0
  var color = ["f34e88", "02b3fe", "a8a8a8"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    refresh()
    setupUI()
  }
  
  override func viewDidLayoutSubviews() {
    cardView.loadViewsIfNeeded()
  }
  
  fileprivate func setupUI() {
    self.configureCardView()
  }
  
  func refresh(isRefresh: Bool = false) {
    if isNetworkReachable {
      print(Utils.sharedInstance.getUserId())
      repository.fetchData()
        .done({ data in
          self.detail = []
          self.detail = data
          if isRefresh {
            for _ in 0..<1 {
              self.cardView.swipeTopViewToLeft()
            }
          }
        })
    } else {
      titleLabel.text = "No Internet Connection!"
      descriptionLabel.isHidden = true
      imageView.isHidden = true
      //alert(StringResource.Errors.k_noInternet)
    }
  }
  
  // MARK: - configure CardView
  func configureCardView() {
    cardView.delegate = self
    cardView.dataSource = self
    cardView.viewAnimator = self
    cardView.numberOfHistoryItem = UInt(detail.count)//UInt.max
    cardView.isUserInteractionEnabled = true
    cardView.numberOfActiveViews = 1
    cardView.translatesAutoresizingMaskIntoConstraints = false
    setUpView(view: cardView)
    view.backgroundColor = UIColor.white
    view.clipsToBounds = true
    cardView.allowedDirection = .all
  }
  
  @IBAction func tappedLogoutButton(_ sender: UIButton) {
    showLogoutConfirmationDialog()
  }
  
  @IBAction func tappedReloadButton(_ sender: UIButton) {
    view.makeToast("Deleted Successfully!", duration: 2.0, position: .center)
  }
  
  // MARK: - setUpView
  func setUpView(view:UIView) {
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOpacity = 0.33
    view.layer.shadowOffset = CGSize(width: 0, height: 1.5)
    view.layer.shadowRadius = 4.0
    view.layer.rasterizationScale = UIScreen.main.scale
    view.layer.cornerRadius = 10.0
    view.layer.shouldRasterize = true
  }
  
  //MARK: ZLSwipeableViewDataSource
  func nextView(for swipeableView: ZLSwipeableView!) -> UIView! {
    
    swipeableView.layoutIfNeeded()
    let view =  UIView(frame: swipeableView.bounds)
    self.setUpView(view: view)
    guard let contentView = Bundle.main.loadNibNamed("CardContentView", owner: self, options: nil)![0] as? UIView else {
      return nil
    }
    
    contentView.translatesAutoresizingMaskIntoConstraints = false
    contentView.layer.cornerRadius = 10
    contentView.layer.masksToBounds = true
    contentView.isUserInteractionEnabled = true
    contentView.isAccessibilityElement = true
    view.addSubview(contentView)
    
    let metrics = ["height": view.bounds.size.height, "width": view.bounds.size.width]
    let views:[String: UIView] = ["contentView" : contentView]
    view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[contentView(width)]", options: [], metrics: metrics, views: views))
    view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[contentView(height)]", options: [], metrics: metrics, views: views))
    
    if cardSwipedAt < detail.count - 1 {
      if let title = detail[cardSwipedAt].title, let des = detail[cardSwipedAt].desc, let img = detail[cardSwipedAt].img {
        titleLabel.text = title
        descriptionLabel.text = des
        self.imageView.sd_setShowActivityIndicatorView(true)
        self.imageView.sd_setIndicatorStyle(.gray)
        self.imageView.sd_setImage(with: URL(string: img), placeholderImage: UIImage(named: ""))
        cardSwipedAt += 1
      }
    } else {
      refresh(isRefresh: true)
      cardSwipedAt = 0
      /*view.accessibilityIdentifier = "default"
       titleLabel.text = "No Data Found"
       descriptionLabel.isHidden = true
       imageView.isHidden = true*/
    }
    
    if colorIndex >= color.count {
      colorIndex = 0
    }
    
    [layerView].forEach({view in
      view!.backgroundColor = UIColor().hexStringToUIColor(hex: color[colorIndex])
    })
    colorIndex += 1
    return view
  }
  
  //MARK: ZLSwipeableViewDelegate
  func swipeableView(_ swipeableView: ZLSwipeableView!, didSwipeView view: UIView!, in direction: ZLSwipeableViewDirection) {
    if direction.rawValue == 8 {
      self.repository.deleteCategory(self.detail[self.cardSwipedAt].id!).done { (success) in
        self.view.makeToast("Deleted Successfully!", duration: 2.0, position: .center)
      }
    }
  }
  
  func swipeableView(_ swipeableView: ZLSwipeableView!, didCancelSwipe view: UIView!) {
    //print("DID CANCEL")
  }
  
  func swipeableView(_ swipeableView: ZLSwipeableView!, didEndSwipingView view: UIView!, atLocation location: CGPoint) {
    //print("did start swiping at location: x %f, y%f", location.x, location.y)
  }
  
  func swipeableView(_ swipeableView: ZLSwipeableView!, didStartSwipingView view: UIView!, atLocation location: CGPoint) {
    //print("did start swiping at location: x %f, y%f", location.x, location.y)
    cardView.allowedDirection = cardView.topView().accessibilityIdentifier == "default" ? .none : .all
  }
  
  func swipeableView(_ swipeableView: ZLSwipeableView!, swipingView view: UIView!, atLocation location: CGPoint, translation: CGPoint) {
    //print("swiping at location: x %f, y %f, translation: x %f, y %f", location.x, location.y, translation.x, translation.y)
  }
  
  func showLogoutConfirmationDialog() {
    let alert = UIAlertController(title: "Warning", message: "Are you sure you want to logout?", preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "YES", style: UIAlertActionStyle.default, handler: { action in
      Utils.sharedInstance.doLogout()
      UserDefaults.standard.set(false, forKey: "status")
      Switcher.updateRootVC()
    }))
    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
    present(alert, animated: true, completion: nil)
  }
}

// MARK: - ZLSwipeableViewAnimator
extension ViewController: ZLSwipeableViewAnimator {
  
  func animate(_ view: UIView!, index: UInt, views: [UIView]!, swipeableView: ZLSwipeableView!) {
    let degree: CGFloat = CGFloat(sin(0.5 * Double(index)))
    let duration: TimeInterval = 0.4
    let offset = CGPoint(x: 0, y: swipeableView.bounds.height * 0.3)
    let translation = CGPoint(x: degree * 10.0, y: CGFloat((-(Double(index) * 5.0))))
    rotateAndTranslate(view, forDegree: Float(degree), translation: translation, duration: duration, atOffsetFromCenter: offset, swipeableView: cardView)
  }
  
  func degrees(toRadians degrees: CGFloat) -> CGFloat {
    return degrees * .pi / 180
  }
  
  func radians(toDegrees radians: CGFloat) -> CGFloat {
    return radians * 180 / .pi
  }
  
  func rotateAndTranslate(_ view: UIView, forDegree degree: Float, translation: CGPoint, duration: TimeInterval, atOffsetFromCenter offset: CGPoint, swipeableView: ZLSwipeableView) {
    let rotationRadian: Float = Float(degrees(toRadians: CGFloat(degree)))
    UIView.animate(withDuration: duration, delay: 0, options: .allowUserInteraction, animations: {() -> Void in
      view.center = swipeableView.convert(swipeableView.center, from: swipeableView.superview)
      var transform = CGAffineTransform(translationX: offset.x, y: offset.y)
      transform = transform.rotated(by: CGFloat(rotationRadian))
      transform = transform.translatedBy(x: -offset.x, y: -offset.y)
      transform = transform.translatedBy(x: translation.x, y: translation.y)
      view.transform = transform
    }) { _ in }
  }
}
