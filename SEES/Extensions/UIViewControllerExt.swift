//
//  UIViewControllerExt.swift
//  SEES
//
//  Created by Robert Parsons on 11/15/20.
//

import UIKit

fileprivate var containerView: UIView!

extension UIViewController {
    
    func presentErrorOnMainThread(withError error: SEESError, optionalMessage message: String? = nil) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: error.info.title, message: error.info.message + (message ?? ""), preferredStyle: .alert)
            alertController.view.tintColor = .systemTeal
            alertController.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(alertController, animated: true)
        }
    }
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) { containerView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.25) {
                containerView.removeFromSuperview()
            }
            containerView = nil
        }
    }
}
