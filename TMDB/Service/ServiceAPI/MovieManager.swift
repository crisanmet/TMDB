//
//  MovieManager.swift
//  TMDB
//
//  Created by Cristian Sancricca on 19/04/2022.
//

import Foundation
import Alamofire
import UIKit

struct MovieManager {
    
    static var shared : MovieManager = {
        return MovieManager()
    }()
    
    private init(){}
    
    public func fetchMovies(completionHandler: @escaping (MovieResponse?) -> () ){
        let baseUrl = K.urlSring
        let apiKey = K.apiKey
        let urlString = "\(baseUrl)api_key=\(apiKey)"
        
        let request = AF.request(urlString, method: .get)
        
        request.response { dataResponse in
            
            if let safeData = dataResponse.data {
                let movies = try? JSONDecoder().decode(MovieResponse.self, from: safeData)
                completionHandler(movies)
        }
    }
}
    public func fetchImages(path: String , completionHandler: @escaping (UIImage?) -> ()){
        let baseUrl = K.imageURL
        let urlString = "\(baseUrl)\(path)"
        
        let request = AF.request(urlString, method: .get)
        
        request.response { dataResponse in
            if let safeImage = dataResponse.data {
                let image = UIImage(data: safeImage)
                    completionHandler(image)
            }
        }
    }
}
