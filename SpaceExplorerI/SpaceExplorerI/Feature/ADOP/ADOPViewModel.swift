//
//  ADOPViewModel.swift
//  SpaceExplorerI
//
//  Created by PSRIMUNWING on 2/3/2569 BE.
//

import Foundation
import RxCocoa
import RxSwift

class ADOPViewModel {
 
    let searchDate = PublishSubject<Date>()
    let items: Driver<[String]>
    
    init() {
        let data = [
            "Select Date"
        ]
        items = Driver.just(data)
    }
    
    func didPressSearch(with date: Date) {
        print("ViewModel: didPressSearch called with: \(date)")
        searchDate.onNext(date)
    }
    
    
    
}
