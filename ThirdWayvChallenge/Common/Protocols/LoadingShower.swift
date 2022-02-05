//
//  LoadingShowe.swift
//  ThirdWayvChallenge
//
//  Created by Mostafa Samir on 06/02/2022.
//

import UIKit

protocol LoadingShower: UIViewController {
    func showLoadingView()
    func dismissLoadingView()
}


extension LoadingShower {
    func showLoadingView(){
        var loadingView: UIView? = view.subviews.first { $0.accessibilityIdentifier == "loadingView" }
        if loadingView == nil {
            view.isUserInteractionEnabled = false
            loadingView = UIView()
            loadingView?.translatesAutoresizingMaskIntoConstraints = false
            loadingView?.accessibilityIdentifier = "loadingView"
            view.addSubview(loadingView!)
            NSLayoutConstraint.activate([
                loadingView!.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                loadingView!.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
            loadingView?.backgroundColor = .clear
            let activityIndicator = UIActivityIndicatorView(style: .medium)
            loadingView?.addSubview(activityIndicator)
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
            activityIndicator.startAnimating()
            loadingView?.updateConstraints()
        }
    }
    
    func dismissLoadingView(){
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view.isUserInteractionEnabled = true
            var loadingView: UIView? = self.view.subviews.first { $0.accessibilityIdentifier == "loadingView" }
            if let _ = loadingView {
                loadingView?.removeFromSuperview()
                loadingView = nil
            }
        }
    }

}
