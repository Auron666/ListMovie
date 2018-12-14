//
//  ListMoviesVC.swift
//  ListMovie
//
//  Created by Benjamin Kolosov on 12/12/2018.
//  Copyright © 2018 BK. All rights reserved.
//


import UIKit

class ListMoviesVC : UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate{
    
    @IBOutlet weak var tableView : UITableView!
    
    let store = DataStore.sharedInstance
    var filteredMovies = [Movie]()
    var shouldShowSearchResults = false
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Movie"
        
        store.getMovies {
            self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movie"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        tableView.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tableView.reloadData()
        }
        searchController.searchBar.resignFirstResponder()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        
        filteredMovies = store.movies.filter({ (movies) -> Bool in
            let titleMovie = movies.title
            let isStringMatch = titleMovie.range(of: searchString!) != nil
            
            return isStringMatch
        })
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults{
            return filteredMovies.count
        }else{
            return store.movies.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MovieTableViewCell = tableView.dequeueReusableCell(withIdentifier: "movieIdentifier", for: indexPath) as! MovieTableViewCell
        let movie : Movie
        
        if shouldShowSearchResults{
            movie = filteredMovies[indexPath.row]
        }else{
            movie = store.movies[indexPath.row]
        }
        
        cell.title.text = movie.title
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow{
                let movie : Movie
                
                if shouldShowSearchResults{
                    movie = filteredMovies[indexPath.row]
                }else{
                    movie = store.movies[indexPath.row]
                }
                
                let vc = segue.destination as! DetailInfoVC
                    vc.titleMovie = movie.title
                    vc.desc = movie.description
                    vc.isFavourite = movie.isFavourite
                
            }
        }
        
    }
    
   
}

