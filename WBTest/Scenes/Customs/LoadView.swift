//
//  LoadView.swift
//  WBTest
//
//  Created by Михаил Шаговитов on 02.10.2023.
//

import UIKit

final class LoadView: UIView {

    let spinner = UIActivityIndicatorView()

    let loadingLabel = UILabel()

    required init() {
        super.init(frame: .zero)
        backgroundColor = .white
        addSubviews()
        makeConstraints()
        setupElement()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupElement() {
        
        loadingLabel.textColor = .gray
        loadingLabel.textAlignment = .center
        loadingLabel.text = "Loading..."
        
        spinner.style = UIActivityIndicatorView.Style.medium
        spinner.startAnimating()

    }
    
    private func addSubviews() {
        addSubview(spinner)
        addSubview(loadingLabel)
    }
    
    private func makeConstraints() {
        spinner.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(200)
            $0.leading.equalTo(safeAreaLayoutGuide).inset(UIScreen.main.bounds.size.width / 3)
            $0.height.width.equalTo(30)
        }
        
        loadingLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(200)
            $0.leading.equalTo(spinner.snp.trailing).inset(20)
            $0.height.equalTo(30)
            $0.width.equalTo(140)
        }
    }
}
