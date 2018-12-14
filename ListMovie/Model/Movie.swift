//
//  Movie.swift
//  ListMovie
//
//  Created by Benjamin Kolosov on 12/12/2018.
//  Copyright © 2018 BK. All rights reserved.
//

import Foundation

struct Movie {
    
    let title       : String
    let description : String
    var isFavourite : Bool
    
    init(dictionary : movieJSON, isFavourite : Bool ) {
        self.title       = dictionary["original_title"] as! String
        self.description = dictionary["overview"] as! String
        self.isFavourite = isFavourite
    }
    
}
