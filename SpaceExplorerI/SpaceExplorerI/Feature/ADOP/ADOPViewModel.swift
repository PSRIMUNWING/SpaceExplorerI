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
    lazy var items: Driver<[ADOPItem]> = buildItems()
    
    private let getADOPUseCase: GetADOPUseCase
    private let disposeBag = DisposeBag()
    let isLoading = BehaviorRelay<Bool>(value: false)
    let errorMessage = PublishRelay<String>()
    
    init(getADOPUseCase: GetADOPUseCase = GetADOPUseCase()) {
        self.getADOPUseCase = getADOPUseCase
    }
    
    private func buildItems() -> Driver<[ADOPItem]> {
        let searchCell = Observable.just([
            ADOPItem.search("Select Date")
        ])
        
        let detailCell = searchDate
            .do(onNext: { [weak self] _ in
                self?.isLoading.accept(true)
            })
            .flatMapLatest { [weak self] date -> Observable<[ADOPItem]> in
                guard let self = self else { return .just([]) }
                return self.fetchApod(date: date)
            }
        
        return Observable.merge(
            searchCell,
            detailCell.map { [ADOPItem.search("Select Date")] + $0 }
        )
        .asDriver(onErrorJustReturn: [])
    }
    
    private func fetchApod(date: Date) -> Observable<[ADOPItem]> {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        let dateString = formatter.string(from: date)
        print(">>> dateString: \(dateString)")
        
        return getADOPUseCase.execute(date: dateString)
            .do(onError: { [weak self] error in
                print(">>> error: \(error)")
                let message = (error as NSError).localizedDescription
                self?.errorMessage.accept(message)
            })
            .map { response -> [ADOPItem] in
                print(">>> response: \(response)")
                return [
                    ADOPItem.image(response.url),
                    ADOPItem.info(InfoModel(title: "Title", detail: response.title)),
                    ADOPItem.info(InfoModel(title: "Date", detail: response.date)),
                    ADOPItem.info(InfoModel(title: "Detail", detail: response.explanation))
                ]
            }
            .catch { _ in .just([]) }
    }
    
    func didPressSearch(with date: Date) {
        searchDate.onNext(date)
    }
}
