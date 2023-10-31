//
//  PosterImageView.swift
//  PopMovie
//
//  Created by Hakan ERDOĞMUŞ on 15.09.2023.
//

import UIKit
import AlamofireImage
import Alamofire

class PosterImageView: UIImageView {
    
    private var dataTask: URLSessionDataTask?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func downloadImage(movie: MoviResult) {
         
        guard let url = URL(string: ApiUrls.imageUrl(posterPath: movie._posterPath)) else { return }
        
        AF.request(url).responseImage { [weak self] (image) in
            guard let image = image.value else {
                print("İmage hata")
                return
            }
            
            DispatchQueue.main.async {
                self?.image = UIImage(cgImage: image.cgImage!)
            }
            
        }
        
        
    }
    
    
    func downloadFavoriteImage(posterPath: Favorite) {
        
        guard let url = URL(string: ApiUrls.imageUrl(posterPath: posterPath._posterPath)) else { return }
        
        AF.request(url).responseImage { [weak self] (image) in
            guard let image = image.value else {
                print("Favorite image error")
                return
            }
            
            DispatchQueue.main.async {
                self?.image = UIImage(cgImage: image.cgImage!)
            }
        }
    }
    
    
    
    func cancelDownloading() {
        dataTask?.cancel()
        dataTask = nil
    }
}
