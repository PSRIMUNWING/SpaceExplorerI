//
//  HomeViewController.swift
//  SpaceExplorerI
//
//  Created by PSRIMUNWING on 1/3/2569 BE.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {

    @IBOutlet weak var firstTitle: UILabel!
    @IBOutlet weak var secondTitle: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var tableTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = HomeViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTable()
        navigation()
    }
    
    func setupView() {
        self.title = "Home"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = AppTheme.navigationBarBackground

        appearance.titleTextAttributes = [
            .foregroundColor: AppTheme.titlePrimary
        ]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        firstTitle.font = AppTextStyle.titlePrimary
        firstTitle.textColor = AppTheme.titlePrimary
        firstTitle.text = "Space"
        
        secondTitle.font = AppTextStyle.titleSecondary
        secondTitle.textColor = AppTheme.titleSecondary
        secondTitle.text = "Explorer"
        
        subtitle.font = AppTextStyle.subtitle
        subtitle.textColor = AppTheme.subtitle
        subtitle.text = "Explore the cosmos through \nNASA data and beyond."
        
        tableTitle.font = AppTextStyle.subtitle
        tableTitle.textColor = AppTheme.subtitle
        tableTitle.text = "FEATURES"
    }
    
    func setupTable() {
        tableView.backgroundColor = .clear
        tableView.register(
            UINib(nibName: "HomeCell", bundle: nil),
            forCellReuseIdentifier: HomeCell.identifier
        )
        
        viewModel.items
                .drive(tableView.rx.items(
                    cellIdentifier: HomeCell.identifier,
                    cellType: HomeCell.self
                )) { _, item, cell in
                    cell.configure(title: item.title,
                                   subtitle: item.subtitle,
                                   icon: item.icon)
                }
                .disposed(by: disposeBag)
    }
    
    func navigation() {
        tableView.rx.modelSelected(TableItem.self)
            .subscribe(onNext: { [weak self] item in
                switch item.route {
                case .adop:
                    let vc = ADOPViewController()
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
    
}
