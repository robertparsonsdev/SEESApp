//
//  UIViewControllerExt.swift
//  SEES
//
//  Created by Robert Parsons on 11/15/20.
//

import UIKit

extension UIViewController {
    func presentErrorOnMainThread(withError error: SEESError, optionalMessage message: String? = nil) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: error.info.title, message: error.info.message + (message ?? ""), preferredStyle: .alert)
            alertController.view.tintColor = .systemTeal
            alertController.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(alertController, animated: true)
        }
    }
}
