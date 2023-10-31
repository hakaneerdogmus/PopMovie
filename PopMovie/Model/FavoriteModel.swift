//
//  FavoriteModel.swift
//  PopMovie
//
//  Created by Hakan ERDOĞMUŞ on 11.10.2023.
//

import Foundation

struct Favorite: Decodable {
    
    let id: Int?
    let posterPath: String?
    let overview, title, releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case posterPath = "poster_path"
        case overview, title
        case releaseDate = "release_date"
        
    }
    
    var _id: Int {
        id ?? Int.min
    }
    
    var _posterPath: String {
        posterPath ?? ""
    }
    
    var _title: String {
        title ?? "N/A"
    }
    
    var _releaseDate: String {
        releaseDate ?? "N/A"
    }
    
    var _overview: String {
        overview ?? "There is no overview!"
    }
}
