//
//  CustomHeader.swift
//  WBTest
//
//  Created by Михаил Шаговитов on 02.10.2023.
//

import Foundation
import UIKit

final class CustomHeader: UIView {
    
    lazy var navTitle: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "AlNile", size: 30)
        return label
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.setImage(UIImage(systemName: "arrowshape.turn.up.left"), for: .normal)
        button.imageView?.isUserInteractionEnabled = false
        return button
    }()
    
    lazy var reloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.setImage(UIImage(systemName: "goforward"), for: .normal)
        button.imageView?.isUserInteractionEnabled = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(navTitle)
        addSubview(backButton)
        addSubview(reloadButton)
    }
    
    private func makeConstraints() {
        backButton.snp.makeConstraints {
            $0.leading.equalTo(safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(30)
            $0.width.equalTo(30)
        }
        
        navTitle.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(10)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        reloadButton.snp.makeConstraints {
            $0.trailing.equalTo(safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(30)
            $0.width.equalTo(30)
        }
    }
}
