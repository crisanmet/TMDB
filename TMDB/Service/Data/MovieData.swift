//
//  MovieData.swift
//  TMDB
//
//  Created by Cristian Sancricca on 19/04/2022.
//

import Foundation

struct Movie: Codable{
    let id: Int
    let title: String
    let overview: String
    let backdropPath: String
    let posterPath: String
    let voteAverage: Double

    var voteAverageToString: String{
        return String(format: "%.1f", voteAverage)
    }
}

extension Movie{
    enum CodingKeys: String, CodingKey{
        case id
        case title
        case overview
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
}

struct MovieResponse: Codable{
    let page: Int?
    let results:[Movie]?
}
