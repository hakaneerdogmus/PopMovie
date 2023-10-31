//
//  MovieViewModel.swift
//  PopMovie
//
//  Created by Hakan ERDOĞMUŞ on 15.09.2023.
//

import Foundation

protocol MovieViewModelProtocol {
    var view: HomeViewProtocol? { get set }
    func viewDidLoad()
    
    
}

final class MovieViewModel {
    weak var view: HomeViewProtocol?
    private let service = NetworkManager()
    var movies: [MoviResult] = []
    private var page: Int = 1
}

extension MovieViewModel: MovieViewModelProtocol {
    func viewDidLoad() {
        
            self.view?.configureVC()
            self.view?.configureCollectionView()
            self.getMovies()
        
      
        
        
    }
    
    func getMovies() {
        service.download(page: page) { [weak self] (returnMovie) in
            guard let self = self else { return }
            guard let returnMovie = returnMovie else { return }
            
            self.movies.append(contentsOf: returnMovie)
            self.view?.reloadCollectionView()
            self.page += 1
            
            
        }
    }
    
    
    func getDetail(id: Int) {
        
        service.downloadDetail(id: id) { [weak self] (returnDetail) in
            guard let self = self else { return }
            guard let returnDetail = returnDetail else { return }
            
            self.view?.navigateDetailScreen(movie: returnDetail)
            
        }
        
    }
    
}
