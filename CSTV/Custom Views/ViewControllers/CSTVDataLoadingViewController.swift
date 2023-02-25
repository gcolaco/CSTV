//
//  SceneDelegate.swift
//  CSTV
//
//  Created by Gustavo Colaço on 25/02/23.
//

import UIKit

class CSTVDataLoadingViewController: UIViewController {

    
    var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = CSTVColors.mainBgColor
        containerView.alpha           = 0
        
        UIView.animate(withDuration: 0.25) {
            self.containerView.alpha = 1
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
        
    }
    
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
    
    
    func showEmptyStateView(in view: UIView) {
        let emptyStateView = CSTVEmptyStateView()
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }

}