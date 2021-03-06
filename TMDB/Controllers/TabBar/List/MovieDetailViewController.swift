//
//  MovieDetailViewController.swift
//  TMDB
//
//  Created by Cristian Sancricca on 20/04/2022.
//

import UIKit
import RealmSwift

class MovieDetailViewController: UIViewController {
    
  
    var selectedMovie : Movie?
    var isTapped:Bool = false
    let realm = try! Realm()
    
    @IBOutlet weak var imageMovie: UIImageView!
    
    @IBOutlet weak var imageMovieSide: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    	
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var setFavorite: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        print(isTapped)
        movieNameLabel.text = selectedMovie?.title
        scoreLabel.text = selectedMovie?.voteAverageToString
        descriptionLabel.text = selectedMovie?.overview
        
        DispatchQueue.global(qos: .userInitiated).async {
            MovieManager.shared.fetchImages(path: self.selectedMovie!.posterPath) { [weak self] (image) in
                DispatchQueue.main.async {
                    self?.imageMovie.image = image
                    self?.imageMovieSide.image = image
                }
            }
        }
    }
    
    @IBAction func setFavoriteTapped(_ sender: UIButton) {
        
        
        isTapped.toggle()
        
        let heart = UIImage(systemName: "heart")
        let heartFill = UIImage(systemName: "heart.fill")
       
        isTapped == false ? sender.setImage(heart, for: .normal) : sender.setImage(heartFill, for: .normal)
        
        sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 1.2, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: .curveEaseOut ,animations: {
            sender.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    
        let movie = MovieRealm()
        movie.name = selectedMovie?.title
        do{
            try realm.write({
                realm.add(movie)
            })
        }catch{
            print(error)
        }
    }
}
