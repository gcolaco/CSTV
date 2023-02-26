//
//  Teams.swift
//  CSTV
//
//  Created by Gustavo Colaço on 26/02/23.
//

import Foundation

struct Teams: Codable {
    let players: [Player]
    let slug: String
}

struct Player: Codable {
    let firstName: String?
    let lastName: String?
    let nickname: String?
    let imageUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case nickname = "name"
        case imageUrl = "image_url"
    }
}
