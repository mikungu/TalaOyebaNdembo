//
//  FavouriteTeamsViewController.swift
//  TalaOyebaNdembo
//
//  Created by Mikungu Giresse on 14/06/23.
//

import UIKit

class FavouriteTeamsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let favouriteTeamModel = FavouriteTeamModel ()
    private var favouriteTeam = [Teams] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.fetchFavourites()
        alertAddFavourite()
    }
    
    func fetchFavourites () {
        favouriteTeamModel.fetchFavorites { [weak self] teamsName in
            self?.favouriteTeam = teamsName
            self?.tableView.reloadData()
            
        }
    }
    
    func alertAddFavourite () {
        if favouriteTeam.count == 0 {
            displayAlert(title: "Error: Aucune équite dans ta liste!", message: "Pour ajouter une équipe dans le favoris, veuillez cliquer sur le like (le pouce levé) dans la page Team", preferredStyle: .alert)
        } else {
            tableView.reloadData()
        }
    }
    
}

extension FavouriteTeamsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favouriteTeam.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteTeamsCell") as? TeamTableViewCell else {
            return UITableViewCell()
        }
        let team = self.favouriteTeam[indexPath.row]
        cell.configure(teams: team)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "DetailTeamFavorite") as? DetailsTeamsViewController {
            vc.teams = self.favouriteTeam[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
}
