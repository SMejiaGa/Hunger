//
//  AppFont.swift
//  Hunger
//
//  Created by Sebastian Mejia on 22/10/21.
//

import Foundation
import UIKit

enum AppFont {
    case bold(size: CGFloat)
    case source(size: CGFloat)
    case serif(size: CGFloat)
    
    /// Default size = 17
    case boldDefaulSize
    
    var defaultSize: CGFloat { 17 }
    var boldFontName: String { "SourceSansPro-Bold" }
    var sourceFontName: String { "SourceCodePro" }
    var serifFontName: String { "PTSerif-Italic" }
    
    var value: UIFont? {
        switch self {
        case .bold(let size):
            return UIFont(name: boldFontName, size: size)
        case .boldDefaulSize:
            return UIFont(name: boldFontName, size: defaultSize)
        case .source(let size):
            return UIFont(name: sourceFontName, size: size)
        case .serif(let size):
            return UIFont(name: serifFontName, size: size)
        }
    }
}
