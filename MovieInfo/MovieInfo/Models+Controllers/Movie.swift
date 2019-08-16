//
//  Movie.swift
//  MovieInfo
//
//  Created by Michael Moore on 8/16/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import Foundation

struct TopLevelMovieDictionary: Codable {
    
    let results: [MovieObject]
}

struct MovieObject: Codable {
    
    let title: String
    let rating: Double
    let summary: String
    let imageURL: String
    
    private enum CodingKeys: String, CodingKey {
        
        case title
        case rating = "vote_average"
        case summary = "overview"
        case imageURL = "poster_path"
        
    }
}
