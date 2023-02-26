//
//  SceneDelegate.swift
//  CSTV
//
//  Created by Gustavo Colaço on 25/02/23.
//

import UIKit

class CSTVEmptyStateView: UIView {
    
    //MARK: - Components

    private let messageLabel: UILabel = {
        let label           = UILabel()
        label.text          = "No momento não encontramos nenhuma partida. Tente novamente mais tarde"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font          = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor     = CSTVColors.lightCSTVBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let logoImageView: UIImageView = {
        let logo            = UIImageView()
        logo.image          = CSTVImages.emptyLogo
        logo.tintColor      = CSTVColors.lightCSTVBlue
        logo.contentMode    = .scaleAspectFill
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
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
        addSubviews(messageLabel, logoImageView)
        backgroundColor = CSTVColors.mainBgColor
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),

            logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 170),
            logoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 90)
        ])
    }
    
}
