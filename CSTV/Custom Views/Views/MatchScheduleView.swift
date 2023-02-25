//
//  SceneDelegate.swift
//  CSTV
//
//  Created by Gustavo Colaço on 25/02/23.
//

import UIKit

class MatchScheduleView: UIView {

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
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = CSTVColors.futureMatchColor
    }

}
