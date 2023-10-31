//
//  FavoriteCell.swift
//  PopMovie
//
//  Created by Hakan ERDOĞMUŞ on 11.10.2023.
//

import UIKit
import SnapKit

class FavoriteCell: UICollectionViewCell {
    
    static let reuseID = "FavoriteCell"
    
    private var posterImageView: PosterImageView!
    private var service = NetworkManager()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureCell()
        configurePosterImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
        posterImageView.cancelDownloading()
    }
    
    private func configureCell() {
        backgroundColor = .systemGray3
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    func setCell(posterPath: Favorite) {
        
                posterImageView.downloadFavoriteImage(posterPath: posterPath)
                //print(favPost)
                //print(posterPath)
        
        
    }
    
    
    private func configurePosterImageView() {
        posterImageView = PosterImageView(frame: .zero)
        addSubview(posterImageView)
        
        posterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
}
