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
        labelMovieName.text = movie.title
        
        MovieManager.shared.fetchImages(path: movie.posterPath) { image in
            DispatchQueue.main.async {
                self.imageMovie.image = image
            }
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
