//
//  DetailsVC.swift
//  WBTest
//
//  Created by Михаил Шаговитов on 02.10.2023.
//

import UIKit

final class DetailsVC: UIViewController {
    
    lazy var contentView = DetailsView(delegate: self)
    
    var dataStore: BrandsDataStore = HomeViewDataStore.shared
    
    private var brand: (Brand, Bool)
    
    required init(brand: (Brand, Bool)) {
        self.brand = brand
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupElement()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
    
    override func loadView() {
        view = contentView
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
    }
    
    private func setupElement() {
        contentView.configure(with: brand)
    }
    
    func setupNavBar(){
        navigationController?.navigationBar.isHidden = true
    }
}

extension DetailsVC: DetailsViewDelegate {
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageViewCell.identifireImageCell, for: indexPath) as? ImageViewCell {
            let data = brand.0.thumbUrls[indexPath.row]
            cell.configure(with: data)
            return cell
        }
        return .init()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brand.0.thumbUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 50, left: 25, bottom: 50, right: 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 50
        return .init(width: width, height: collectionView.bounds.height)
    }
    
    func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }

    func didTapLikeButton() {
        var index = 0
        while dataStore.brands[index].0.brandId != self.brand.0.brandId {
            index += 1
        }
        
        if brand.1 {
            contentView.likeButton.backgroundColor = .systemBlue
            contentView.likeButton.tintColor = .white
            dataStore.brands[index].1 = false
        } else {
            contentView.likeButton.backgroundColor = .white
            contentView.likeButton.tintColor = .red
            dataStore.brands[index].1 = true
        }
    }

}
