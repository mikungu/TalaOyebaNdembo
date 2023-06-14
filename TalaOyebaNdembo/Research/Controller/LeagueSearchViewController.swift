//
//  LeagueSearchViewController.swift
//  TalaOyebaNdembo
//
//  Created by Mikungu Giresse on 14/06/23.
//

import UIKit

class LeagueSearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let leaguesModel = LeagueModel(httpClient: APIService())
    var filteredLeague = [Leagues] ()
    var searching = false
    private let leagueSavedModel = LeagueSavedModel ()
    
    var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.reloadData()
        
        self.tableView.tableFooterView = createSpinnerFooter()
        
        leaguesModel.getLeague{[weak self] result in
            self?.tableView.tableFooterView = nil
            switch result {
            case .success(let value):
                print(value)
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
                self?.displayAlert(title: "Oups, Error!", message: "There is a \(error). Please control your Network and Try again!", preferredStyle: .alert)
            }
        }
        configureSearchController()
        
        
        
    }
    
    
    func configureSearchController () {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.search
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Select and Search by League"
        
    }
    
    private func addLeague () {
        guard let leagueName = searchController.searchBar.text!.addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: "<>!*();^:@&=+$,|/?%#[]{}~’\" ").inverted)
        else { return }
        leagueSavedModel.saveLeague(named: leagueName, completion: { leaguesName in
        })
    }
}

extension LeagueSearchViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return filteredLeague.count
        } else {
            return self.leaguesModel.leagues.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LeaguesCell", for: indexPath) as? LeagueTableViewCell else {
            return UITableViewCell()
        }
        
        if searching {
            let leagueFiltered = filteredLeague[indexPath.row]
            cell.configure(league: leagueFiltered)
        } else {
            let league = self.leaguesModel.leagues[indexPath.row]
            cell.configure(league: league)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searching {
            let cell = filteredLeague[indexPath.row].strLeague
            self.searchController.searchBar.text = cell
        } else {
            let cell = leaguesModel.leagues[indexPath.row].strLeague
            self.searchController.searchBar.text = cell
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        self.filteredLeague.removeAll()
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchData = searchController.searchBar.text!
        if !searchData.isEmpty {
            searching = true
            filteredLeague.removeAll()
            
            for league in leaguesModel.leagues {
                if league.strLeague.lowercased().contains(searchData.lowercased()) {
                    self.filteredLeague.append(league)
                }
            }
        } else {
            filteredLeague = leaguesModel.leagues
            filteredLeague.removeAll()
            searching = false
        }
        tableView.reloadData()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchData = searchController.searchBar.text!
        if searchData.isEmpty == true {
            displayAlert(title: "Oups, Error!", message: "Please, write or select a league name!", preferredStyle: .alert)
        } else {
            performSegue(withIdentifier: "ShowTeamsList", sender: nil)
            
        }
        addLeague()
    }
}

