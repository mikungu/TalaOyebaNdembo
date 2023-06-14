//
//  TeamTableViewCell.swift
//  TalaOyebaNdembo
//
//  Created by Mikungu Giresse on 14/06/23.
//

import UIKit

class TeamTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageCell: UIImageView!
    
    @IBOutlet weak var teamLabel: UILabel!
    
    @IBOutlet weak var leagueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure (teams: Teams) {
        imageCell.downloaded(from: teams.strTeamBadge ?? "")
        teamLabel.text = teams.strTeam
        leagueLabel.text = teams.strLeague
    }
    
}
