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
        setupNavigation()
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
        
        tableView.rx.modelSelected(TableItem.self)
                    .subscribe(onNext: { [weak self] item in
                        self?.viewModel.didSelectItem(item)
                    })
                    .disposed(by: disposeBag)
    }
    
    // MARK: NAVIGATION
    
    private func setupNavigation() {
        //ALTERNATIVE WAY: https://medium.com/nerd-for-tech/mvvm-coordinators-ios-architecture-tutorial-fb27eaa36470
        viewModel.navigationEvent
            .subscribe(onNext: { [weak self] route in
                switch route {
                case .adop:
                    self?.navigateToADOP()
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func navigateToADOP() {
        let storyboard = UIStoryboard(name: "ADOP", bundle: nil)
        let vc = storyboard.instantiateViewController(
            withIdentifier: "ADOP"
        ) as! ADOPViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

