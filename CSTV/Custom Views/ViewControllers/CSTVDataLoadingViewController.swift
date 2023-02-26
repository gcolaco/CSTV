//
//  SceneDelegate.swift
//  CSTV
//
//  Created by Gustavo Colaço on 25/02/23.
//

import UIKit

class CSTVDataLoadingViewController: UIViewController {

    //MARK: - Component
    
    var containerView: UIView!

    //MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }

    //MARK: - useful methods

    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = CSTVColors.mainBgColor
        containerView.alpha           = 0
        
        UIView.animate(withDuration: 0.25) {
            self.containerView.alpha = 1
        }
        
        let activityIndicator   = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
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
        let emptyStateView      = CSTVEmptyStateView()
        emptyStateView.frame    = view.bounds
        view.addSubview(emptyStateView)
    }

}
