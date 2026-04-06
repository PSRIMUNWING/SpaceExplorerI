//
//  InfoCell.swift
//  SpaceExplorerI
//
//  Created by PSRIMUNWING on 2/3/2569 BE.
//

import UIKit

class InfoCell: UITableViewCell {
    
    static let identifier = "InfoCell"
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var detail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        viewCell.backgroundColor = .clear
        
        titleCell.font = AppTextStyle.titleCell
        titleCell.textColor = AppTheme.titlePrimary
        
        detail.font = AppTextStyle.subtitleCell
        detail.textColor = AppTheme.subtitle
    }

    func configure(with title: String, info: String) {
        titleCell.text = title
        detail.text = info
    }

}
