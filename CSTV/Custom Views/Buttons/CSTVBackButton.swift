//
//  SceneDelegate.swift
//  CSTV
//
//  Created by Gustavo Colaço on 25/02/23.
//

import UIKit

class CSTVBackButton: UIButton {
    
    //MARK: - Life cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Configuration method
    
    private func configure() {
        setImage(CSTVImages.backArrow, for: .normal)
        tintColor = .white
        translatesAutoresizingMaskIntoConstraints = false
    }

}
