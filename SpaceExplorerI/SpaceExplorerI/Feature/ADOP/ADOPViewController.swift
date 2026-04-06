//
//  ADOPViewController.swift
//  SpaceExplorerI
//
//  Created by PSRIMUNWING on 2/3/2569 BE.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

class ADOPViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = ADOPViewModel()
    private let disposeBag = DisposeBag()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
        bindError()
        
        viewModel.isLoading
            .asDriver()                              // 👈 convert to Driver
            .drive(activityIndicator.rx.isAnimating) // 👈 drive instead of bind
            .disposed(by: disposeBag)
        
        setupView()
        setupTable()
    }
    
    private func bindError() {
        viewModel.errorMessage
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] message in
                self?.showAlert(message: message)
            })
            .disposed(by: disposeBag)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(
            title: "An error occurred",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(
            title: "OK",
            style: .default,
            handler: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
        ))
        present(alert, animated: true)
    }
    
    func setupView() {
        self.title = "Astronomy Picture"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = AppTheme.navigationBarBackground
        
        appearance.titleTextAttributes = [
            .foregroundColor: AppTheme.titlePrimary
        ]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupActivityIndicator() {
        activityIndicator.color = .white
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setupTable() {
        tableView.backgroundColor = .clear
        tableView.register(
            UINib(nibName: "DataSearchCell", bundle: nil),
            forCellReuseIdentifier: DataSearchCell.identifier
        )
        
        tableView.register(
            UINib(nibName: "ImageCell", bundle: nil),
            forCellReuseIdentifier: ImageCell.identifier
        )
        
        tableView.register(
            UINib(nibName: "InfoCell", bundle: nil),
            forCellReuseIdentifier: InfoCell.identifier
        )
        
        viewModel.items
            .drive(tableView.rx.items) {
                (tableView: UITableView, row: Int, item: ADOPItem)
                -> UITableViewCell in
                
                let indexPath = IndexPath(row: row, section: 0)
                
                switch item {
                case .search(let title):
                    let cell =
                    tableView.dequeueReusableCell(
                        withIdentifier: DataSearchCell.identifier,
                        for: indexPath
                    ) as! DataSearchCell
                    
                    cell.configure(title: title)
                    return cell
                    
                case .image(let urlString):
                    let cell = tableView.dequeueReusableCell(
                        withIdentifier: ImageCell.identifier,
                        for: indexPath
                    ) as! ImageCell
                    
                    let bag = self.disposeBag
                    cell.configure(with: urlString)
                        .observe(on: MainScheduler.instance)
                        .subscribe(onNext: { [weak self] in
                            self?.viewModel.isLoading.accept(false)
                        })
                        .disposed(by: bag)
                    return cell
                    
                case .info(let infoModel):
                    let cell =
                    tableView.dequeueReusableCell(
                        withIdentifier: InfoCell.identifier,
                        for: indexPath
                    ) as! InfoCell
                    
                    cell.configure(
                        with: infoModel.title,
                        info: infoModel.detail
                    )
                    return cell
                }
            }
            .disposed(by: disposeBag)
        
        //MARK: Get Date from Cell and Send Date to VM
        tableView.rx.willDisplayCell
            .subscribe(onNext: { [weak self] cell, _ in
                if let searchCell = cell as? DataSearchCell {
                    let searchSubject = PublishSubject<Date>()
                    searchCell.onSearchPressed = searchSubject
                    
                    searchSubject
                        .subscribe(onNext: { [weak self] date in
                            self?.viewModel.didPressSearch(with: date)
                            print(
                                "ViewController: Received date from cell: \(date)"
                            )
                        })
                        .disposed(by: self?.disposeBag ?? DisposeBag())
                }
            })
            .disposed(by: disposeBag)
    }
    
}

enum ADOPItem {
    case search(String)
    case image(String)
    case info(InfoModel)
}

struct InfoModel {
    let title: String
    let detail: String
}
