//
//  ViewController+Extension.swift
//  TalaOyebaNdembo
//
//  Created by Mikungu Giresse on 14/06/23.
//

import UIKit

extension UIViewController {
    
    func displayAlert(title: String, message: String, preferredStyle: UIAlertController.Style) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    func createSpinnerFooter () -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 200))
        let spinner = UIActivityIndicatorView()
        spinner.color = .black
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
}

