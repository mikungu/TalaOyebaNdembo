//
//  DetailsTeamsViewController.swift
//  TalaOyebaNdembo
//
//  Created by Mikungu Giresse on 14/06/23.
//

import UIKit

class DetailsTeamsViewController: UIViewController {
    
    //MARK: -Outlets
    
    @IBOutlet weak var imageTeam: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var leagueLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var webButton: UIButton!
    
    //MARK: -Properties
    var teams: Teams?
    var team = [Teams] ()
    var searchModel = SearchModel(httpClient: APIService())
    private let favouriteTeamModel = FavouriteTeamModel()
    
    
    //MARK: -Override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imageUrl = teams?.strTeamBanner {
            imageTeam.downloaded(from: imageUrl)
        } else {
            imageTeam.image = UIImage(named: "soccerball")
        }
        countryLabel.text = teams?.strCountry
        leagueLabel.text = teams?.strLeague
        descriptionTextView.text = teams?.strDescriptionEN
        
        self.navigationItem.title = teams?.strTeam
        
        elementsAccessibility()
        
        //light and dark mode
        descriptionTextView.textColor = UIColor.black
        if #available(iOS 13.0, *) {
            descriptionTextView.textColor = UIColor.label
        }
        
        favouriteButton.setTitle("", for: [])
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let isFavouriteTeam = self.checkIfFavourite()
        self.favouriteButton.tintColor = .gray
        self.likeLabel.text = "Like"
        self.likeLabel.textColor = .gray
        if isFavouriteTeam {
            self.favouriteButton.tintColor = .link
            self.likeLabel.text = "Is Liked"
            self.likeLabel.textColor = .link
        }
    }
    
    func elementsAccessibility () {
        
        favouriteButton.isAccessibilityElement = true
        favouriteButton.accessibilityHint = "Like button for adding or removing a team from the favourite's list"
        
        imageTeam.isAccessibilityElement = true
        imageTeam.accessibilityHint = "The team's banner"
        
        countryLabel.isAccessibilityElement = true
        countryLabel.accessibilityHint = "Country's Name"
        
        leagueLabel.isAccessibilityElement = true
        leagueLabel.accessibilityHint = "League's name"
        
        webButton.isAccessibilityElement = true
        webButton.accessibilityHint = "WebButton to get access to the team's website"
        
        likeLabel.isAccessibilityElement = true
        likeLabel.accessibilityHint = "The status of the team in the favourite list"
        
        descriptionTextView.isAccessibilityElement = true
        descriptionTextView.accessibilityHint = "The Team's description"
        
    }
    
    private func checkIfFavourite() -> Bool {
        guard let teamName = self.teams?.strTeam else {
            return false }
        return favouriteTeamModel.checkIfFavorite(teamName: teamName)
    }
    
    private func deleteFromFavourite() {
        guard let teamName = self.teams?.strTeam else { return }
        favouriteTeamModel.deleteFromFavorite(teamName: teamName)
    }
    
    //MARK: -Actions
    @IBAction func makeFavourite(_ sender: Any) {
        guard let team = teams else { return }
        
        let isFavourite = favouriteTeamModel.checkIfFavorite(teamName: team.strTeam )
        if isFavourite {
            favouriteTeamModel.deleteFromFavorite(teamName: team.strTeam )
            self.favouriteButton.tintColor = .gray
            self.likeLabel.text = "Like"
            self.likeLabel.textColor = .gray
        } else {
            favouriteTeamModel.addFavorite(team: team)
            self.favouriteButton.tintColor = .link
            self.likeLabel.text = "Is Liked"
            self.likeLabel.textColor = .link
        }
    }
    
    @IBAction func goToWebSIte(_ sender: Any) {
        guard let url = URL(string: "https://\(teams?.strWebsite ?? "")") else { return }
        let vc = WebViewController(url: url, title: "WebSite")
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true )
    }
    
    
}
