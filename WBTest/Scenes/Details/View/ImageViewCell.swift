//
//  ImageCell.swift
//  WBTest
//
//  Created by Михаил Шаговитов on 02.10.2023.
//

import UIKit

class ImageViewCell: UICollectionViewCell {

    private var loadImageTask: Task<Void, Never>?
    private let imageBrand = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupElements()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }

    public func getImage() -> UIImage? {
        return imageBrand.image
    }
    
    func setupElements() {
        imageBrand.contentMode = .scaleAspectFill
        imageBrand.clipsToBounds = true
        imageBrand.layer.cornerRadius = 5
    }
    
    func configure(with data: String){
        configureIcon(for: URL(string: data)!)
    }
    
    private func configureIcon(for url: URL) {
        loadImageTask?.cancel()
        
        loadImageTask = Task { [weak self] in
            self?.imageBrand.image = nil
            do {
                try await self?.imageBrand.setImage(by: url)
            } catch {
                self?.imageBrand.image = UIImage(systemName: "logo")
            }
        }
    }
    
    private func setupViews() {
        contentView.addSubview(imageBrand)
    }

    public func getImageView() -> UIImageView {
            return imageBrand
    }
    
    private func setupLayout() {
        
        imageBrand.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalTo(safeAreaLayoutGuide).inset(0)
        }
    }
}

extension ImageViewCell {
    
    static var nibImageCell : UINib{
        return UINib(nibName: identifireImageCell, bundle: nil)
    }
    
    static var identifireImageCell : String{
        return String(describing: self)
    }
}
