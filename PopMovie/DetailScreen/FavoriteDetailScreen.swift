//
//  FavoriteDetailScreen.swift
//  PopMovie
//
//  Created by Hakan ERDOĞMUŞ on 13.10.2023.
//

import UIKit
import SnapKit

protocol FavoriteDetailScreenProtocol: AnyObject {
    func configureVC()
    func configureScrollView()
    func configurePosterImageView()
    func downloadPosterImage()
    func configureTitleLabel()
    func configureDateLabel()
    func configureOverviewLabel()
    func didTapButton()
    func favoriteIcon()
    func viewWillApear()
}

class FavoriteDetailScreen: UIViewController, DetailScreenProtocol {
    
    private let favoriteMovie: Favorite
    private let detailViewModel = DetailViewModel()
    //private let userDefaults = UserDefault.shared
    
    private let padding: CGFloat = 16
   // private let defaults = UserDefaults.standard
    private var favControl: Bool = false
    
    private let scrollView = UIScrollView()
    private var posterImageView: PosterImageView!
    private var titleLabel: UILabel!
    private var dateLabel: UILabel!
    private var overviewLabel: UILabel!
    
    init(favoriteMovie: Favorite) {
        self.favoriteMovie = favoriteMovie
      
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailViewModel.view = self
        detailViewModel.viewDidLoad()
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        detailViewModel.viewWillAppear()
    }
}

extension FavoriteDetailScreen: FavoriteDetailScreenProtocol {
    
    func viewWillApear() {
        //MARK: Kaydedilen verileri gösteriyor
       //userDefaults.getData()
        UserDefault.shared.getData()
        
        //MARK: Tüm verileri temizleme
        //userDefaults.allRemoveData()
    }
    
    func favoriteIcon() {
        //MARK: Favorite Icon
        
//        self.favControl = userDefaults.favorites.contains(movie._posterPath) ? true : false
//        self.favControl = (userDefaults.defaults.object(forKey: "") != nil)
        
        self.favControl = UserDefault.shared.favorites.contains(favoriteMovie._id) ? true : false
        //self.favControl = (UserDefault.shared.defaults.object(forKey: UserDefault.shared.key) != nil)
        
        DispatchQueue.main.async {
           
            if(self.favControl == true) {
                print("dolu")
                
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(image:  UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(self.didTapButton))
                
            }
            else {
                print("boş")
                
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(self.didTapButton))
            }
        }
        
    }
    
    
    func configureVC() {
        view.backgroundColor = .systemBackground
        
    }
    
    //MARK: Favori ekleme Butonu
    @objc func didTapButton() {

        //favControl = userDefaults.favorites.contains(poster) ? true : false
       // favControl.toggle()
        DispatchQueue.main.async { [self] in
            if((self.favControl == false) && (UserDefault.shared.favorites.contains(favoriteMovie._id) == false)) {
                //MARK: Verileri kaydetme işlemi
                
                UserDefault.shared.saveData(id: self.favoriteMovie._id)
                
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(image:  UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(self.didTapButton))
            }
            else {
                //MARK: Silme işlemi burada yapılacak
                UserDefault.shared.deleteData(id: self.favoriteMovie._id)
                print("boş")
                
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(self.didTapButton))
            }
            
            print(self.favControl)
            
        }
           
    }
        
    func configureScrollView() {
        
        view.addSubview(scrollView)
        
        scrollView.isScrollEnabled = true
          
        scrollView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    func configurePosterImageView() {
        posterImageView = PosterImageView(frame: .zero)
        scrollView.addSubview(posterImageView)
        
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
       
        posterImageView.layer.cornerRadius = 16
        posterImageView.clipsToBounds = true
    
        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(10)
            make.width.equalTo(UIScreen.main.bounds.width * 0.6)
            make.height.equalTo(UIScreen.main.bounds.width * 0.6 * 1.5)
            make.centerX.equalTo(scrollView)
            
        }
    }
    
    func downloadPosterImage() {
        posterImageView.downloadFavoriteImage(posterPath: favoriteMovie)
    }
    
    func configureTitleLabel() {
        titleLabel = UILabel(frame: .zero)
        scrollView.addSubview(titleLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.numberOfLines = 0
        titleLabel.text = favoriteMovie._title
        titleLabel.textAlignment = .center
        
        titleLabel.font = .boldSystemFont(ofSize: 25)

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(20)
            make.width.equalTo(UIScreen.main.bounds.width * 0.9)
            make.centerX.equalTo(scrollView)

        }
    }
    
    func configureDateLabel() {
        dateLabel = UILabel(frame: .zero)
        scrollView.addSubview(dateLabel)

        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.text = favoriteMovie._releaseDate
        dateLabel.font = .systemFont(ofSize: 18)
        dateLabel.textColor = .secondaryLabel

        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.centerX.equalTo(scrollView)
        }
    }
    
    func configureOverviewLabel() {
        
        overviewLabel = UILabel(frame: .zero)
        scrollView.addSubview(overviewLabel)

        overviewLabel.translatesAutoresizingMaskIntoConstraints = false

        overviewLabel.text = favoriteMovie._overview
       
        overviewLabel.font = .systemFont(ofSize: 20)
        overviewLabel.numberOfLines = 0

        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(20)
            make.width.equalTo(UIScreen.main.bounds.width * 0.95)
            make.centerX.equalTo(scrollView)
            make.bottomMargin.equalToSuperview()
        }
    }
}
