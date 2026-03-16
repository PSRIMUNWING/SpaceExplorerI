//
//  ADOPViewController.swift
//  SpaceExplorerI
//
//  Created by PSRIMUNWING on 2/3/2569 BE.
//

import Foundation
import UIKit
import RxSwift

class ADOPViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = ADOPViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTable()
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
    
    func setupTable() {
        tableView.backgroundColor = .clear
        tableView.register(
            UINib(nibName: "DataSearchCell", bundle: nil),
            forCellReuseIdentifier: DataSearchCell.identifier
        )
        
        viewModel.items
            .drive(tableView.rx.items(
                cellIdentifier: DataSearchCell.identifier,
                cellType: DataSearchCell.self
            )) { _, item, cell in
                cell.configure(title: item)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.willDisplayCell
            .subscribe(onNext: { [weak self] cell, _ in
                if let searchCell = cell as? DataSearchCell {
                    let searchSubject = PublishSubject<Date>()
                    searchCell.onSearchPressed = searchSubject
                    
                    searchSubject
                        .subscribe(onNext: { [weak self] date in
                            self?.viewModel.didPressSearch(with: date)
                            print("ViewController: Received date from cell: \(date)")
                        })
                        .disposed(by: self?.disposeBag ?? DisposeBag())
                }
            })
            .disposed(by: disposeBag)
    }
    
    
    
}
