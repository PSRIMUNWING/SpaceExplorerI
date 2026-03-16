//
//  DataSearchCell.swift
//  SpaceExplorerI
//
//  Created by PSRIMUNWING on 2/3/2569 BE.
//

import UIKit
import RxSwift

class DataSearchCell: UITableViewCell {
    
    static let identifier = "DataSearchCell"
    var disposeBag = DisposeBag()
    var onSearchPressed: PublishSubject<Date> = PublishSubject()
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var searchButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        //View
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        view.backgroundColor = AppTheme.navigationBarBackground
        view.layer.cornerRadius = 18
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor

        //Component
        titleCell.font = AppTextStyle.titleItalicCell
        titleCell.textColor = AppTheme.titleSecondary
                
        datePicker.layer.backgroundColor = UIColor.white.cgColor
        datePicker.layer.cornerRadius = 10
        datePicker.maximumDate = Date()
        
        searchButton.titleLabel?.font = AppTextStyle.subtitle
        searchButton.titleLabel?.textColor = AppTheme.titlePrimary
        searchButton.backgroundColor = AppTheme.buttonBackground
        searchButton.layer.cornerRadius = 10
//        searchButton.setBackgroundColor(AppTheme.buttonBackground, for: .highlighted)
//        searchButton.setTitleColor(AppTheme.titlePrimary, for: .highlighted)
        
        //TODO: CUSTOM STYLE
        setupRxButtonAction()
    }
    
    private func setupRxButtonAction() {
        searchButton.rx.tap
            .subscribe(onNext: { [weak self] in
                let selectedDate = self?.datePicker.date ?? Date()
                self?.onSearchPressed.onNext(selectedDate)
            })
            .disposed(by: disposeBag)
    }
    
    func configure(title: String) {
        titleCell.text = title
    }
    
}
