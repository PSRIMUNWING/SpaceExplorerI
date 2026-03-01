//
//  AppTextStyle.swift
//  SpaceExplorerI
//
//  Created by PSRIMUNWING on 1/3/2569 BE.
//

import Foundation
import UIKit

enum AppTextStyle {
    
    static let titlePrimary: UIFont = {
        return UIFont(name: "TimesNewRomanPS-BoldMT", size: 42)
            ?? UIFont.systemFont(ofSize: 42, weight: .bold)
    }()
    
    static let titleSecondary: UIFont = {
        return UIFont(name: "Georgia-Italic", size: 38)
        ?? UIFont.systemFont(ofSize: 38, weight: .semibold)
    }()
    
    static let subtitle: UIFont = {
        return UIFont(name: "TimesNewRomanPS-Light", size: 14)
        ?? UIFont.systemFont(ofSize: 14, weight: .light)
    }()
    
    static let titleCell: UIFont = {
        return UIFont(name: "TimesNewRomanPS-BoldMT", size: 14)
        ?? UIFont.systemFont(ofSize: 14, weight: .bold)
    }()

    static let subtitleCell: UIFont = {
        return UIFont(name: "Georgia-Italic", size: 12)
        ?? UIFont.systemFont(ofSize: 12, weight: .semibold)
    }()

    
    

}
