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
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var searchButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        titleCell.textColor = AppTheme.titlePrimary
        titleCell.font = AppTextStyle.titleCell
        
        
    }
    
}
