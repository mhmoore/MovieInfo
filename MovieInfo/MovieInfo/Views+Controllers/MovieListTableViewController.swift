//
//  MovieListTableViewController.swift
//  MovieInfo
//
//  Created by Michael Moore on 8/16/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController, UISearchBarDelegate {
    // MARK: - Outlets
    
    @IBOutlet weak var movieSearchBar: UISearchBar!
    // MARK: - Properties
    var movies: [MovieObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearchBar.delegate = self
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! ItemTableViewCell
        let movieItem = movies[indexPath.row]
        cell.movie = movieItem
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        MovieController.fetchItem(searchTerm: searchTerm) { (movies) in
            self.movies = movies
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
