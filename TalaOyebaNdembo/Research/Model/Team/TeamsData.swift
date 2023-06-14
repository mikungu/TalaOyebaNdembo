//
//  TeamsData.swift
//  TalaOyebaNdembo
//
//  Created by Mikungu Giresse on 14/06/23.
//

import Foundation

struct TeamsData: Decodable {
    let teams: [Teams]
}
struct Teams: Decodable {
    let strTeam: String
    let strLeague: String
    let strWebsite: String?
    let strDescriptionEN: String?
    let strCountry: String?
    let strTeamBadge: String?
    let strTeamBanner: String?
    
}
