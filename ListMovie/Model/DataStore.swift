//
//  DataStore.swift
//  ListMovie
//
//  Created by Benjamin Kolosov on 12/12/2018.
//  Copyright © 2018 BK. All rights reserved.
//

import Foundation
import UIKit

final class DataStore{
    
    static let sharedInstance = DataStore()
    fileprivate init() {}
    
    var movies: [Movie] = []
    
    func getMovies(completion: @escaping () -> Void){
        
        let baseURL = "http://api.themoviedb.org/3/discover/movie"
        let network = Networking(url: baseURL)
        
        network.getToken { (json) in
            
            let results = json?["results"] as! [movieJSON]
            
            for dict in results{
                let isFavourite = UserDefaults.standard.bool(forKey: "favor")
                
                let newMovie = Movie(dictionary: dict, isFavourite: isFavourite)
                self.movies.append(newMovie)
            }
            
            completion()
        }
        
    }
    
}
