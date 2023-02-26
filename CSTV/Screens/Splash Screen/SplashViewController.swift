//
//  SceneDelegate.swift
//  CSTV
//
//  Created by Gustavo Colaço on 25/02/23.
//

import UIKit

private enum Sizing {
    static let logoWidth: CGFloat = 113
    static let logoHeight: CGFloat = 113
}

final class SplashViewController: UIViewController {
    
    //MARK: - Components
    private let fuzeLogo: UIImageView = {
        let logo = UIImageView(image: CSTVImages.fuzeLogo)
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        let delayTime = DispatchTime.now() + .seconds(4)
        DispatchQueue.main.asyncAfter(deadline: delayTime) { [weak self] in
            guard let self = self else { return }
            self.launchMainScreen()
        }
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: - Configuration method
    
    private func setupUI() {
        view.backgroundColor = CSTVColors.mainBgColor
        view.addSubview(fuzeLogo)
        addPulsingAnimation(to: fuzeLogo)
        
        NSLayoutConstraint.activate([
            fuzeLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fuzeLogo.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            fuzeLogo.widthAnchor.constraint(equalToConstant: Sizing.logoWidth),
            fuzeLogo.heightAnchor.constraint(equalToConstant: Sizing.logoHeight),
        ])
        
    }
    
    
    //MARK: - Private Methods
    
    private func launchMainScreen() {
        let mainScreenNavigationController = UINavigationController(rootViewController: MainScreenViewController())
        self.view.window?.rootViewController = mainScreenNavigationController
        self.view.window?.makeKeyAndVisible()
    }
    
    private func addPulsingAnimation(to imageView: UIImageView) {
        // This animation that scales the image
        let scaleAnimation          = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.duration     = 1.5
        scaleAnimation.repeatCount  = .infinity
        scaleAnimation.autoreverses = false
        scaleAnimation.fromValue    = 1.0
        scaleAnimation.toValue      = 1.1
        
        // This is reponsible for the opacity animation
        let opacityAnimation            = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.duration       = 1.5
        opacityAnimation.repeatCount    = .infinity
        opacityAnimation.autoreverses   = true
        opacityAnimation.fromValue      = 1.0
        opacityAnimation.toValue        = 0.5
        
        // Joins the animations together and add them to the image view's layer
        let animationGroup          = CAAnimationGroup()
        animationGroup.animations   = [scaleAnimation, opacityAnimation]
        animationGroup.duration     = 1.5
        animationGroup.repeatCount  = .infinity
        imageView.layer.add(animationGroup, forKey: "pulse")
    }

    
}
