//
//  MoviCell.swift
//  PopMovie
//
//  Created by Hakan ERDOĞMUŞ on 15.09.2023.
//

import UIKit
import SnapKit

class MovieCell: UICollectionViewCell {

    static let reuseID = "MovieCell"
    
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
    
    
    
    
    
    
    //MARK: Hücre ayarı
    private func configureCell() {
        backgroundColor = .systemGray3
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    
    func setCell(movie: MoviResult) {
        posterImageView.downloadImage(movie: movie)
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

    
