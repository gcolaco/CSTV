//
//  Matches.swift
//  CSTV
//
//  Created by Gustavo Colaço on 25/02/23.
//

import Foundation

struct Matches: Codable {
    let league: League
    let opponents: [Opponent]
    let status: String
    let beginAt: String?
    let serie: SerieInfo
    private enum CodingKeys: String, CodingKey {
        case league, opponents, status, serie
        case beginAt = "begin_at"
    }
}

struct League: Codable {
    let imageUrl: String?
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
        case name
    }
}

struct Opponent: Codable {
    let opponent: OpponentInfo
}

struct OpponentInfo: Codable {
    let imageUrl: String?
    let name: String
    let id: Int
    
    private enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
        case name, id
    }
}

struct SerieInfo: Codable {
    let name: String?
}
