//
//  NetworkManager.swift
//  PopMovie
//
//  Created by Hakan ERDOĞMUŞ on 14.09.2023.
//

import UIKit
import Alamofire
import AlamofireImage



class NetworkManager {
    static let shared = NetworkManager()
    
    var image: String?
  
    

    func downloadFavorite(id: Int, completion: @escaping (Favorite?) -> ()) {
       
                guard let url = URL(string: ApiUrls.detail(id: id)) else { return }
                
                AF.request(url).responseDecodable(of:Favorite.self) { [weak self] (result) in
                    guard let result = result.value else {
                        completion(nil)
                        print("Favorite detail error")
                        return
                    }
                    completion(result)
                }
                
            
        
    }
    
    
    func download(page: Int,completion: @escaping ([MoviResult]?) -> Void) {
        
        guard let url = URL(string: ApiUrls.movieUrl(page: page)) else { return }
        
        
        AF.request(url).responseDecodable(of: Movie.self) { [weak self] (model) in
        
            guard let data = model.value else {
                completion(nil)
                print("Download Error")
                return
            }
            
            completion(data.results)
            
        }
    }
    
    
    func downloadDetail(id: Int, completion: @escaping (MoviResult?) -> ()) {
        
        guard let url = URL(string: ApiUrls.detail(id: id)) else { return }
        
        AF.request(url).responseDecodable(of:MoviResult.self) { [weak self] (result) in
            
            guard let result = result.value else {
                completion(nil)
                print("Detail Error")
                return
            }
            
            completion(result)
        }
    }
    
    func downloadFavoriteDetail(id: Int, completion: @escaping (Favorite?) -> ()) {
     
        guard let url = URL(string: ApiUrls.detail(id: id)) else { return }
        
        AF.request(url).responseDecodable(of: Favorite.self) { [weak self] (result) in
            
            guard let result = result.value else {
                completion(nil)
                print("Favorite Detail Error")
                return
            }
            
            completion(result)
        }
    }
}
