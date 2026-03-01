//
//  HomeViewModel.swift
//  SpaceExplorerI
//
//  Created by PSRIMUNWING on 1/3/2569 BE.
//

import Foundation
import RxCocoa
import UIKit

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

    // Output
    let items: Driver<[TableItem]>

    init() {
        let data = [
            TableItem(
                title: "Astronomy Picture",
                subtitle: "NASA APOD — Daily image",
                icon: UIImage(named: "ic-telescope"),
                route: .adop)
            
//Example for adding the next one
//            TableItem(title: "Venus",
//                     subtitle: "The second rock from the Sun",
//                     icon: UIImage(named: "logo-launch")),
        ]
        items = Driver.just(data)
    }
    
}
