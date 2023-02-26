//
//  SceneDelegate.swift
//  CSTV
//
//  Created by Gustavo Colaço on 25/02/23.
//

import UIKit

final class FirstTeamLineUpView: UIView {

    //MARK: - Components

    private let firstTeamPlayerImg: UIImageView = {
        let logo                = UIImageView()
        logo.layer.cornerRadius = 8
        logo.contentMode        = .scaleAspectFit
        logo.clipsToBounds      = true
        logo.tintColor          = CSTVColors.futureMatchColor
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.image = CSTVImages.playerImgPlaceholder
        return logo
    }()
    
    private let firstTeamPlayerNickname: UILabel = {
        let label                         = UILabel(frame: .zero)
        label.textColor                   = CSTVColors.lightCSTVBlue
        label.adjustsFontSizeToFitWidth   = true
        label.minimumScaleFactor          = 0.6
        label.lineBreakMode               = .byTruncatingTail
        label.textAlignment               = .right
        label.font                        = CSTVFont.robotoRegular(size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let firstTeamPlayerName: UILabel = {
        let label                         = UILabel(frame: .zero)
        label.textColor                   = CSTVColors.lightCSTVBlue
        label.adjustsFontSizeToFitWidth   = true
        label.minimumScaleFactor          = 0.6
        label.lineBreakMode               = .byTruncatingTail
        label.textAlignment               = .right
        label.font                        = CSTVFont.robotoRegular(size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    //MARK: - Life cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: [.bottomRight, .topRight], radius: 12.0)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration method

    private func configureUI() {
        addSubviews(firstTeamPlayerImg, firstTeamPlayerNickname, firstTeamPlayerName)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = CSTVColors.cellColor
        clipsToBounds = false
        
        NSLayoutConstraint.activate([
            firstTeamPlayerImg.topAnchor.constraint(equalTo: topAnchor, constant: -3),
            firstTeamPlayerImg.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            firstTeamPlayerImg.heightAnchor.constraint(equalToConstant: 50),
            firstTeamPlayerImg.widthAnchor.constraint(equalToConstant: 50),
            firstTeamPlayerNickname.centerYAnchor.constraint(equalTo: firstTeamPlayerImg.centerYAnchor),
            firstTeamPlayerNickname.trailingAnchor.constraint(equalTo: firstTeamPlayerImg.leadingAnchor, constant: -16),
            firstTeamPlayerNickname.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            firstTeamPlayerName.topAnchor.constraint(equalTo: firstTeamPlayerNickname.bottomAnchor, constant: 6),
            firstTeamPlayerName.leadingAnchor.constraint(equalTo: firstTeamPlayerNickname.leadingAnchor),
            firstTeamPlayerName.trailingAnchor.constraint(equalTo: firstTeamPlayerNickname.trailingAnchor)
        ])
        
    }
    
    //MARK: - Setup method

    func setupView(with player: Player) {
        if let playerImgUrl = player.imageUrl {
            firstTeamPlayerImg.downloadImageForCash(fromUrl: playerImgUrl)
        }
        
        if let playerFirstName = player.firstName, let playerLastName = player.lastName {
            firstTeamPlayerName.text = playerFirstName + " " + playerLastName
        } else {
            firstTeamPlayerName.text = "Unknown"
        }
        
        firstTeamPlayerNickname.text = player.nickname ?? "Unknown"
        
    }

}
