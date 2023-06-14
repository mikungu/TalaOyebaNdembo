//
//  LeagueData.swift
//  TalaOyebaNdembo
//
//  Created by Mikungu Giresse on 14/06/23.
//

import Foundation


struct LeagueData: Decodable {
    let leagues: [Leagues]
}
struct Leagues: Decodable {
    let strLeague: String
    let strSport: String
}
