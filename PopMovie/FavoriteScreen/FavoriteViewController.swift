//
//  FavoriteViewController.swift
//  PopMovie
//
//  Created by Hakan ERDOĞMUŞ on 25.09.2023.
//

import UIKit
import SnapKit

protocol FavoriteViewControllerProtocol: AnyObject {
    func configureVC()
    func configureCollectionView()
    func reloadCollectionView()
    func navigateDetailScreen(movie: Favorite)
    
}


class FavoriteViewController: UIViewController {
    
    private let defaults = UserDefaults()
    private var collectionView: UICollectionView!
    private let favoriteViewModel = FavoriteViewModel()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        favoriteViewModel.view = self
        favoriteViewModel.viewDidLoad()
        //favoriteViewModel.getFavoriteMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoriteViewModel.viewWillAppear()
        favoriteViewModel.getFavoriteMovies()
        
        if(UserDefault.shared.favorites == []) {
            UserDefault.shared.allRemoveData()
            reloadCollectionView()
        }
        //print(favoriteViewModel.movies)
        
    }
}

extension FavoriteViewController: FavoriteViewControllerProtocol {
 
    
    func configureVC() {
        view.backgroundColor = .systemPink
        
        
        //UserDefault.shared.getData()
        //UserDefault.shared.allRemoveData()
        
    }
    
    func createFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 30, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 15, height: UIScreen.main.bounds.width * 0.75)
        layout.minimumLineSpacing = 25
        return layout
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createFlowLayout())
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(FavoriteCell.self, forCellWithReuseIdentifier: FavoriteCell.reuseID)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func reloadCollectionView() {
        collectionView.reloadOnMainThread()
    }
    
    func navigateDetailScreen(movie: Favorite) {
        DispatchQueue.main.async {
            let detailScreen = FavoriteDetailScreen(favoriteMovie: movie)
            self.navigationController?.pushViewController(detailScreen, animated: true)
        }
    }
    
}

extension FavoriteViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UserDefault.shared.favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.reuseID, for: indexPath) as! FavoriteCell
        if indexPath.item < favoriteViewModel.movies.count {
            cell.setCell(posterPath: favoriteViewModel.movies[indexPath.item])
        }else {
            print("Hata burada")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        favoriteViewModel.getDetail(id: favoriteViewModel.movies[indexPath.item]._id)
    }
}



