//
//  HomeView.swift
//  PopMovie
//
//  Created by Hakan ERDOĞMUŞ on 14.09.2023.
//

import UIKit
import SnapKit
import AlamofireImage

protocol HomeViewProtocol: AnyObject {
    func configureVC()
    func configureCollectionView()
    func reloadCollectionView()
    func navigateDetailScreen(movie: MoviResult)
}
class HomeView: UIViewController {
    private let movieViewModel = MovieViewModel()
    private var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        movieViewModel.view = self
        movieViewModel.viewDidLoad()
    }
}
extension HomeView: HomeViewProtocol {
    func configureVC() {
        view.backgroundColor = .orange
        UserDefault.shared.getData()
    }
    //MARK: CollectionView layout cellerin gözükne ayarı
    func createFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        //CollectionView in dikey olarak scroll edilebilir olduğunu belirttik
        layout.scrollDirection = .vertical
        //Saüdan soldan üsttten alltan bırakılan boşluk ayarı
        layout.sectionInset = UIEdgeInsets(top: 30, left: 10, bottom: 0, right: 10)
        //Herbir hücre için ayar geniişilk ayarı ile yan yana 2 tane cel görünmesini ayarladık
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 15 , height: UIScreen.main.bounds.width * 0.75)
        //Aradaki boşluklar Yatay yani alt alta olan cellerin mesafe boşlukları
        layout.minimumLineSpacing = 25
        return layout
    }
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createFlowLayout())
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseID)
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
    func navigateDetailScreen(movie: MoviResult) {
        DispatchQueue.main.async {
            let detailScreen = DetailScreen(movie: movie)
            self.navigationController?.pushViewController(detailScreen, animated: true)
        }
    }
}
extension HomeView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieViewModel.movies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseID, for: indexPath) as! MovieCell
        cell.setCell(movie: movieViewModel.movies[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        movieViewModel.getDetail(id: movieViewModel.movies[indexPath.item]._id)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        if (offsetY >= (contentHeight - (2 * height))) {
            movieViewModel.getMovies()
        }
    }
}
//Reload Data
extension UICollectionView {
    func reloadOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
