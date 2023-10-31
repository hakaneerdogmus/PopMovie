//
//  DetailViewModel.swift
//  PopMovie
//
//  Created by Hakan ERDOĞMUŞ on 16.09.2023.
//

import Foundation

protocol DetailViewModelProtocol {
    var view: DetailScreenProtocol? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
}

final class DetailViewModel {
    weak var view: DetailScreenProtocol?
}

extension DetailViewModel: DetailViewModelProtocol {

    
    func viewDidLoad() {
        view?.configureVC()
        view?.configureScrollView()
        view?.configurePosterImageView()
        view?.downloadPosterImage()
        view?.configureTitleLabel()
        view?.configureDateLabel()
        view?.configureOverviewLabel()
        
    }
    
    func viewWillAppear() {
        view?.viewWillApear()
        view?.favoriteIcon()

    }
    
    
}
