//
//  HomeViewModel.swift
//  SpaceExplorerI
//
//  Created by PSRIMUNWING on 1/3/2569 BE.
//

import Foundation
import RxCocoa
import UIKit
import RxSwift  

struct TableItem {
    let title: String
    let subtitle: String
    let icon: UIImage?
    let route: HomeRoute
}

enum HomeRoute {
    case adop
}

class HomeViewModel {
    
    private let disposeBag = DisposeBag()
    
    // Output
    let items: Driver<[TableItem]>
    let navigationEvent = PublishSubject<HomeRoute>()
    let selectedItem = PublishSubject<TableItem>()

    init() {
        let data = [
            TableItem(
                title: "Astronomy Picture",
                subtitle: "NASA APOD — Daily image",
                icon: UIImage(named: "ic-telescope"),
                route: .adop)
        ]
        items = Driver.just(data)
        setupNavigation()
    }
    
    func didSelectItem(_ item: TableItem) {
        selectedItem.onNext(item)
    }
    
    private func setupNavigation() {
        selectedItem
            .subscribe(onNext: { [weak self] item in
                self?.navigationEvent.onNext(item.route)
            })
            .disposed(by: disposeBag)
    }
    
}
