//
//  MovieListViewController.swift
//  TMDB
//
//  Created by Cristian Sancricca on 20/04/2022.
//

import UIKit

class MovieListViewController: UIViewController  {
    
    var moviesList = [Movie]()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.global(qos: .userInitiated).async {
            MovieManager.shared.fetchMovies { [weak self] (movies) in
                self?.moviesList = movies?.results ?? []
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
    }

}

//MARK: - TableView Delegate & DataSource

extension MovieListViewController: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = moviesList[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! MovieTableViewCell
       
        cell.updateInfo(movie: movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToDetailView", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! MovieDetailViewController
          
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedMovie = moviesList[indexPath.row]
         }
    }
}
