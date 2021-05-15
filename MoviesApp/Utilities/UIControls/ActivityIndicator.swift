//
//  ActivityIndicator.swift
//  MoviesApp
//
//  Created by Arpit Jain on 14/05/21.
//

import UIKit

class ActivityIndicator: NSObject {
    
    // MARK: - Properties
    
    private static var activityIndicator = UIActivityIndicatorView.init(style: .whiteLarge)
    private static var overlayView = UIView()
    
    private static var visibleViewController: UIViewController? {
        var currentVc = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
        while let presentedVc = currentVc?.presentedViewController {
            if let navVc = (presentedVc as? UINavigationController)?.viewControllers.last {
                currentVc = navVc
            } else if let tabVc = (presentedVc as? UITabBarController)?.selectedViewController {
                currentVc = tabVc
            } else {
                currentVc = presentedVc
            }
        }
        return currentVc
    }
    
    // MARK: - User Defined Methods
    
    class func show() {
        
        DispatchQueue.main.async {
            guard let window = APPDELEGATE.window else {
                return
            }
            overlayView.backgroundColor = UIColor.clear
            overlayView.frame = window.bounds
            activityIndicator.color = UIColor.lightGray
            activityIndicator.hidesWhenStopped = true
            window.addSubview(overlayView)
            window.addSubview(activityIndicator)
            activityIndicator.center = window.center
            window.bringSubviewToFront(overlayView)
            window.bringSubviewToFront(activityIndicator)
            activityIndicator.startAnimating()
        }
    }
    
    class func hide() {
        
        DispatchQueue.main.async {
            guard let window = APPDELEGATE.window else {
                return
            }
            _ = window.subviews.filter({
                if  $0 is UIActivityIndicatorView { $0.removeFromSuperview() }
                return true
            })
            overlayView.removeFromSuperview()
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
}

