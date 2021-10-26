//
//  AppColor.swift
//  Hunger
//
//  Created by Sebastian Mejia on 22/10/21.
//

import Foundation
import UIKit

enum AppColor {
    case blue
    case green
    
    var value: UIColor? {
        switch self {
        case .blue:
            return UIColor(named: "BrandBlue")
        case .green:
            return UIColor(named: "BrandGreen")
        }
    }
}
