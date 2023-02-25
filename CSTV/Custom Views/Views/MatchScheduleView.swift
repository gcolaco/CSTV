//
//  SceneDelegate.swift
//  CSTV
//
//  Created by Gustavo Colaço on 25/02/23.
//

import UIKit

class MatchScheduleView: UIView {
    
    private let matchTimeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "AGORA"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 8)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: [.bottomLeft, .topRight], radius: 16.0)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(matchTimeLabel)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = CSTVColors.liveMatchColor
        
        NSLayoutConstraint.activate([
            matchTimeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            matchTimeLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
    }

}
