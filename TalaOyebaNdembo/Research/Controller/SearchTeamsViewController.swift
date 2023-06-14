//
//  SearchTeamsViewController.swift
//  TalaOyebaNdembo
//
//  Created by Mikungu Giresse on 14/06/23.
//

import UIKit

class SearchTeamsViewController: UIViewController {
    
    
    var searchModel = SearchModel(httpClient: APIService())
    private let leagueSavedModel = LeagueSavedModel ()
    var searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = createSpinnerFooter()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        searchModel.getTeamsLeague () {[weak self] result in
            self?.tableView.tableFooterView = nil
            switch result {
            case  .success(let value):
                print(value)
                self?.tableView.reloadData()
            case.failure(let error):
                print(error)
                self?.displayAlert(title: "Oups, Error!", message: "There is a \(error). Please control your Network and Try again!", preferredStyle: .alert)
            }
        }
        getLeaguePlus()
    }
    
}

extension SearchTeamsViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchModel.team.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TeamsCell", for: indexPath) as? TeamTableViewCell else {
            return UITableViewCell()
        }
        let teams = self.searchModel.team[indexPath.row]
        
        cell.configure(teams: teams)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailTeam") as? DetailsTeamsViewController {
            vc.teams = searchModel.team[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    @objc func loadTable() {
        self.tableView.reloadData()
    }
    
    
    private func getLeaguePlus () {
        leagueSavedModel.getLeague(completion: {[weak self] leaguesName in
            for item in leaguesName {
                self?.searchController.searchBar.text = item.name
            }
            
        })
    }
}
