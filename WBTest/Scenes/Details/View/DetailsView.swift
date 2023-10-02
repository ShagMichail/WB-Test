//
//  DetailsView.swift
//  WBTest
//
//  Created by Михаил Шаговитов on 02.10.2023.
//

import UIKit
import SnapKit

protocol DetailsViewDelegate: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func didTapBackButton()
    func didTapLikeButton()
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
}

final class DetailsView: UIView {
    
    weak var delegate: DetailsViewDelegate?
    
    lazy var headerView: CustomHeader = {
        var view = CustomHeader()
        view.backgroundColor = .systemBlue
        view.reloadButton.removeFromSuperview()
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var imageCollection: UICollectionView = {
        let layout = AccountTableLayout()
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: .init(), collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isPagingEnabled = false
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        return collection

    }()
    
    lazy var numberOfViewsLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    lazy var likeButton: UIButton = {
        var button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 10
        button.layer.cornerRadius = 20
        button.setImage(UIImage(named: "likeRed"), for: .normal)
        return button
    }()
    
    required init(delegate: DetailsViewDelegate) {
        super.init(frame: .zero)
        addSubviews()
        makeConstraints()
        setupElement()
        imageCollection.delegate = delegate
        imageCollection.dataSource = delegate

        self.delegate = delegate
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupElement() {
        headerView.backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        imageCollection.register(ImageViewCell.self, forCellWithReuseIdentifier: ImageViewCell.identifireImageCell)
    }
    
    func configure(with data: (Brand, Bool)) {
        nameLabel.text = "Выбранный регион: \(data.0.title)"
        numberOfViewsLabel.text = "Количество просмотров: \(data.0.viewsCount)"
        
        if data.1 {
            likeButton.backgroundColor = .white
            likeButton.tintColor = .red
        } else {
            likeButton.backgroundColor = .systemBlue
            likeButton.tintColor = .white
        }
    }
    
    private func addSubviews() {
        addSubview(headerView)
        addSubview(nameLabel)
        addSubview(imageCollection)
        addSubview(numberOfViewsLabel)
        addSubview(likeButton)
    }
    
    private func makeConstraints() {
        headerView.snp.makeConstraints {
            $0.top.equalTo(0)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(120)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).inset(-15)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(30)
        }
        
        imageCollection.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).inset(-15)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(0)
            $0.height.equalTo(200)
        }
        
        numberOfViewsLabel.snp.makeConstraints {
            $0.leading.equalTo(safeAreaLayoutGuide).inset(30)
            $0.top.equalTo(imageCollection.snp.bottom).inset(-15)
        }
        
        likeButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(UIScreen.main.bounds.size.width / 2.5)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(75)
        }
  
    }
    
    @objc func didTapBackButton() {
        delegate?.didTapBackButton()
    }
    
    @objc func didTapLikeButton() {
        delegate?.didTapLikeButton()
    }
}
