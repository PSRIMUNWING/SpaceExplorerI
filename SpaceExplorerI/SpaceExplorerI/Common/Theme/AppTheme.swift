//
//  AppTheme.swift
//  SpaceExplorerI
//
//  Created by PSRIMUNWING on 1/3/2569 BE.
//

import Foundation
import UIKit

enum AppTheme {

    // MARK: - Base Colors
    static let navigationBarBackground = UIColor(
        red: 13/255,
        green: 27/255,
        blue: 58/255,
        alpha: 1
    )
    
    static let titlePrimary = UIColor(hex: "#FFFFFF")
    static let titleSecondary = UIColor(hex: "#4E9BFF")
    static let subtitle = UIColor(hex: "#8A8AB0")
    
}

extension UIColor {
    
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hex.replacingOccurrences(of: "#", with: ""))
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let g = CGFloat((rgb >> 8) & 0xFF) / 255.0
        let b = CGFloat(rgb & 0xFF) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}
