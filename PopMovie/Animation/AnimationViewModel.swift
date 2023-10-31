//
//  AnimationViewModel.swift
//  PopMovie
//
//  Created by Hakan ERDOĞMUŞ on 15.10.2023.
//

import Foundation

protocol AnimationViewModelProtocol {
    var view: AnimationViewProtocol? { get set }
    
    func viewDidLoad()
}

final class AnimationViewModel {
    weak var view: AnimationViewProtocol?
}

extension AnimationViewModel: AnimationViewModelProtocol {
    func viewDidLoad() {

        view?.configureAnimation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.view?.stopAnimation()
            self.view?.pushNavigation()
        }
        
    }
}
