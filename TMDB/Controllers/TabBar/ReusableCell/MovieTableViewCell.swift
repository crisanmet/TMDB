//
//  MovieTableViewCell.swift
//  TMDB
//
//  Created by Cristian Sancricca on 20/04/2022.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

  
    @IBOutlet weak var imageMovie: UIImageView!
    
    @IBOutlet weak var labelMovieName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateInfo(movie:Movie){
        MovieManager.shared.fetchImages(path: movie.posterPath) {[weak self] image in
            DispatchQueue.main.async {
                self?.labelMovieName.text = movie.title
                self?.imageMovie.image = image
            }
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
