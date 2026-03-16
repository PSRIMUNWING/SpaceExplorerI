//
//  ADOPViewController.swift
//  SpaceExplorerI
//
//  Created by PSRIMUNWING on 2/3/2569 BE.
//

import Foundation
import UIKit

class ADOPViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Astronomy Picture"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = AppTheme.navigationBarBackground

        appearance.titleTextAttributes = [
            .foregroundColor: AppTheme.titlePrimary
        ]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        setupTable()
    }
    
    func setupTable() {
        tableView.backgroundColor = .clear
        tableView.register(
            UINib(nibName: "DataSearchCell", bundle: nil),
            forCellReuseIdentifier: DataSearchCell.identifier
        )
    }
    
    
    
}
