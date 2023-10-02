//
//  HomeViewCell.swift
//  WBTest
//
//  Created by Михаил Шаговитов on 02.10.2023.
//

import UIKit
import SnapKit

final class HomeViewCell: UITableViewCell {
    
    private var loadImageTask: Task<Void, Never>?
    static let identifier = "CustomGroopTableViewCell"
    lazy var container = UIView()
    lazy var gradient = CAGradientLayer()

    lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var likeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "likeRed")
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .default
        contentView.backgroundColor = .clear
        
        setupViews()
        setupGradient()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    func getImageView() -> UIImageView {
        return mainImageView
    }

    func configure(brand: (Brand, Bool) ) {
        nameLabel.text = brand.0.title
        configureIcon(for: URL(string: brand.0.thumbUrls[0])!)
        if brand.1 {
            likeImageView.isHidden = false
        } else {
            likeImageView.isHidden = true
        }
    }
    
    private func configureIcon(for url: URL) {
        loadImageTask?.cancel()
        
        loadImageTask = Task { [weak self] in
            self?.mainImageView.image = nil
            
            do {
                try await self?.mainImageView.setImage(by: url)
            } catch {
                self?.mainImageView.image = UIImage(systemName: "logo")
            }
        }
    }
    
    private func setupViews() {
        addSubview(mainImageView)
        mainImageView.addSubview(container)
        container.layer.addSublayer(gradient)
        mainImageView.addSubview(nameLabel)
        mainImageView.addSubview(likeImageView)
    }
    
    private func setupGradient() {
        gradient.colors = [UIColor.black.withAlphaComponent(1.0).cgColor,
                                UIColor.black.withAlphaComponent(0.0).cgColor]
        gradient.locations = [0.0, 0.35]
        gradient.bounds = bounds.insetBy(dx: -0.5 * bounds.size.width, dy: -0.5 * bounds.size.height)
        gradient.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: -1, b: 0, c: 0, d: -5.8, tx: 1, ty: 3.4))
        gradient.position = center
        gradient.cornerRadius = layer.cornerRadius
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
    }
    
    private func setupLayout() {
        
        mainImageView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalTo(safeAreaLayoutGuide).inset(10)
        }
        container.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalTo(mainImageView)
        }
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(mainImageView).inset(20)
            $0.trailing.equalTo(mainImageView).inset(20)
            $0.bottom.equalTo(mainImageView).inset(20)
        }
        likeImageView.snp.makeConstraints {
            $0.bottom.equalTo(mainImageView).inset(20)
            $0.trailing.equalTo(mainImageView).inset(20)
            $0.height.equalTo(26)
            $0.width.equalTo(30)
        }
    }
}
