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
        
        let request = AF.request(urlString, method: .get, encoding: URLEncoding.default)
        
        request.responseDecodable(of: MovieResponse.self, decoder: JSONDecoder()){ response in
            print(response)
            switch response.result{
            case .success(let dataResponse):
                completionHandler(dataResponse)
            case .failure(let errorData):
                print(errorData)
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
