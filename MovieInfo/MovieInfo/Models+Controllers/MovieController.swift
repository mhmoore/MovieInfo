//
//  MovieController.swift
//  MovieInfo
//
//  Created by Michael Moore on 8/16/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import Foundation
import UIKit.UIImage

class MovieController {
    
    static func fetchItem(searchTerm: String, completion: @escaping([MovieObject]) -> Void) {
        guard let baseURL = URL(string: "https://api.themoviedb.org/3/search/movie") else { completion([]); return }
        let apiKey = "db7eb00a2c5fa63fea7054afebf30b60"
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let keyQueryItem = URLQueryItem(name: "api_key", value: apiKey)
        let searchTermQueryItem = URLQueryItem(name: "query", value: searchTerm)
        urlComponents?.queryItems = [keyQueryItem, searchTermQueryItem]
        guard let finalURL = urlComponents?.url else { completion([]); return }
        print(finalURL.absoluteString)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("There was an error fetching item. \(error): \(error.localizedDescription)")
                completion([])
                return
            }
            
            guard let data = data else { completion([]); return }
            
            do {
                let topLevelDictionary = try JSONDecoder().decode(TopLevelMovieDictionary.self, from: data)
                completion(topLevelDictionary.results)
            } catch {
                print("There was an error decoding. \(error): \(error.localizedDescription)")
                completion([])
                return
            }
        }.resume()
    }
    
    static func fetchImage(image: MovieObject, completion: @escaping(UIImage?) -> Void) {
        guard let baseImageURL = URL(string: "https://image.tmdb.org/t/p/original") else { completion(nil); return }
        let finalURL = baseImageURL.appendingPathComponent("\(image.imageURL)")
        print(finalURL)
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("There was an error fetching the image. \(error): \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else { completion(nil); return }
            
            let image = UIImage(data:data)
            completion(image)
        }.resume()
    }
}
