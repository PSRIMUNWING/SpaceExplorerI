//
//  HomeCell.swift
//  SpaceExplorerI
//
//  Created by PSRIMUNWING on 1/3/2569 BE.
//

import UIKit

class HomeCell: UITableViewCell {

    static let identifier = "HomeCell"
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var subtitleCell: UILabel!
    @IBOutlet weak var iconCell: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        //View
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        viewCell.backgroundColor = AppTheme.navigationBarBackground
        viewCell.layer.cornerRadius = 18
        viewCell.layer.masksToBounds = true
        viewCell.layer.borderWidth = 1
        viewCell.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        
        //Component
        titleCell.textColor = AppTheme.titlePrimary
        titleCell.font = AppTextStyle.titleCell
        subtitleCell.textColor = AppTheme.titleSecondary
        subtitleCell.font = AppTextStyle.subtitleCell
    }

    func configure(title: String,
                   subtitle: String,
                   icon: UIImage?) {
        titleCell.text = title
        subtitleCell.text = subtitle
        iconCell.image = icon
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
}
