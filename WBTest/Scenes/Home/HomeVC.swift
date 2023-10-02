//
//  ViewController.swift
//  WBTest
//
//  Created by Михаил Шаговитов on 02.10.2023.
//

import UIKit
import SnapKit

final class HomeVC: UIViewController {
    
    var dataStore: BrandsDataStore = HomeViewDataStore.shared
    
    private let viewModel = HomeControllerViewModel()
    
    lazy var contentView = HomeView(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupModel()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
        contentView.table.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    override func loadView() {
        view = contentView
    }
    
    private func setupModel() {
        
        contentView.loadingView.isHidden = false
        
        self.viewModel.onBrandsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.contentView.table.reloadData()
                self?.contentView.loadingView.isHidden = true
            }
        }
        
        self.viewModel.onErrorMessage = { [weak self] error in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                
                switch error {
                case .serverError(let serverError):
                    alert.title = "Server Error \(serverError.errorCode)"
                    alert.message = serverError.errorMessage
                case .unknown(let string):
                    alert.title = "Error Fetching Coins"
                    alert.message = string
                case .decodingError(let string):
                    alert.title = "Error Parsing Data"
                    alert.message = string
                }
                
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupView() {
        tabBarController?.tabBar.backgroundImage = UIImage()
    }
    
    func easyLoadImageWithURL(for imageView: UIImageView, with imageURL: String) {
        if let url = URL(string: imageURL) {
            do {
                let data = try Data(contentsOf: url)
                imageView.image = UIImage(data: data)

            }catch
            {
                imageView.image = UIImage(named: "logo")
            }
        }
    }
}

//MARK: - Table View Delegate

extension HomeVC: HomeViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let currentCell = tableView.cellForRow(at: indexPath) as? HomeViewCell else { return }
        let brand = self.dataStore.brands[indexPath.row]
        let rootVC = DetailsVC(brand: brand)
        rootVC.contentView.headerView.navTitle.text = "Регион"
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataStore.brands.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewCell.identifier, for: indexPath) as? HomeViewCell else { return UITableViewCell()}
        let brand = self.dataStore.brands[indexPath.row]
        cell.configure(brand: brand)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UILabel()
    }
    
    func didTapReloadButton() {
        contentView.loadingView.isHidden = false
        self.viewModel.fetchBrands()
    }
}
