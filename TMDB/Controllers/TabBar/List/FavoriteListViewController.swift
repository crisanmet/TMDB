//
//  FavoriteListViewController.swift
//  TMDB
//
//  Created by Cristian Sancricca on 20/04/2022.
//

import UIKit
import RealmSwift

class FavoriteListViewController: UIViewController {
    
    var favoritesMovies: Results<MovieRealm>?
    let realm = try! Realm()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        loadFavorites()
      
    }
    
    func loadFavorites(){
            favoritesMovies = realm.objects(MovieRealm.self)
            self.tableView.reloadData()
    
    }

}

//MARK: - TableView Delegate & DataSource


extension FavoriteListViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesMovies?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! MovieTableViewCell
        
        cell.labelMovieName?.text = favoritesMovies?[indexPath.row].name ?? "No favorites added yet"
   
        return cell
    }
}
