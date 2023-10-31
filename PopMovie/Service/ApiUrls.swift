//
//  ApiUrls.swift
//  PopMovie
//
//  Created by Hakan ERDOĞMUŞ on 15.09.2023.
//

import Foundation

enum ApiUrls {
    static func movieUrl(page: Int) -> String {
        return "https://api.themoviedb.org/3/movie/popular?api_key=4ad87e31e1315663d7f1dc14cc9120d5&language=en-US&page=\(page)"
    }
    
    static func imageUrl(posterPath: String) -> String {
        return "https://image.tmdb.org/t/p/w500/\(posterPath)"
    }
    
    static func detail(id: Int) -> String {
        return "https://api.themoviedb.org/3/movie/\(id)?api_key=4ad87e31e1315663d7f1dc14cc9120d5&language=en-US"
    }
}
