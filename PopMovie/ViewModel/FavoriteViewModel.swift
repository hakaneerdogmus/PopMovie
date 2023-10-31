//
//  FavoriteViewModel.swift
//  PopMovie
//
//  Created by Hakan ERDOĞMUŞ on 8.10.2023.
//

import Foundation

protocol FavoriteViewModelProtocol {
    var view: FavoriteViewControllerProtocol? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
}

final class FavoriteViewModel {
    weak var view: FavoriteViewControllerProtocol?
    private let service = NetworkManager()
    var movies: [Favorite] = []
    
    var idControl = false
    
}

extension FavoriteViewModel: FavoriteViewModelProtocol {
    func viewDidLoad() {
        view?.configureVC()
        view?.configureCollectionView()
        //getFavoriteMovies()
        
    }
    
    func viewWillAppear() {
       getFavoriteMovies()
        
    }
    
    func getFavoriteMovies() {
        print(UserDefault.shared.favorites)
        self.movies.removeAll()
        
        if let savedID = UserDefaults.standard.array(forKey: UserDefault.shared.key) as? [Int] {
            for id in savedID {
                
                idControl = UserDefault.shared.favorites.contains(id) ? true : false
                print(idControl)
                
                if(idControl == true ) {
                    service.downloadFavorite(id: id) { [weak self] (returnedFavorite) in
                        guard let self = self else { return }
                        guard let returnedFavorite = returnedFavorite else { return }
                        
                            
                            self.movies.append(returnedFavorite)
                            print(movies)
                            self.view?.reloadCollectionView()
                        
                    }
                }
             
            }
        }
           
    }
    
    
    
    
    
    func getDetail(id: Int) {
        
        service.downloadFavoriteDetail(id: id) { [weak self] (returnDetail) in
            guard let self = self else { return }
            guard let returnDetail = returnDetail else { return }
            
            self.view?.navigateDetailScreen(movie: returnDetail)
            
        }
        
    }
    
    
}
