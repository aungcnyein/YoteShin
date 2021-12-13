//
//  UIViewController.swift
//  YoteShin
//
//  Created by Aung Chan Nyein on 12/9/21.
//

import UIKit

extension UIViewController {
    
    func showLoadingView(at view: UIView) -> UIView {
        let spinnerView = UIView.init(frame: view.bounds)
        
        let activityIndicator = UIActivityIndicatorView.init()
        activityIndicator.center = spinnerView.center
        activityIndicator.color = .gray
        activityIndicator.startAnimating()
        
        let textLabel = UILabel.init(frame: .zero)
        textLabel.text = "LOADING"
        textLabel.textAlignment = .center
        textLabel.textColor = .gray
        textLabel.font = UIFont.systemFont(ofSize: 12)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        DispatchQueue.main.async {
            spinnerView.addSubview(activityIndicator)
            spinnerView.addSubview(textLabel)
            view.addSubview(spinnerView)

            NSLayoutConstraint.activate([
                textLabel.centerXAnchor.constraint(equalTo: spinnerView.centerXAnchor),
                textLabel.centerYAnchor.constraint(equalTo: spinnerView.centerYAnchor, constant: 25)
            ])
        }
        
        return spinnerView
    }
    
    func hideLoadingView(at view: UIView) {
        view.removeFromSuperview()
    }
    
}
