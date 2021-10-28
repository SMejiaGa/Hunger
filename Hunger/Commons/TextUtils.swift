//
//  TextUtils.swift
//  Hunger
//
//  Created by Sebastian Mejia on 22/10/21.
//

import Foundation
import UIKit

typealias HighlightConfig = (text: String, color: AppColor, font: AppFont)

class TextUtils {
    static func highlightTexts(
        in label: UILabel,
        config: [HighlightConfig]
    ) {
        let textConfig = NSMutableAttributedString(string: label.text ?? .init())
        
        config.forEach { item in
            let rangeToHighlight = textConfig.mutableString.range(of: item.text, options: .caseInsensitive)
            var attributes: [NSAttributedString.Key: Any] = [:]
            
            attributes[.font] = item.font.value
            attributes[.foregroundColor] = item.color.value
            textConfig.addAttributes(attributes, range: rangeToHighlight)
        }
        
        label.attributedText = textConfig
    }
    
    static func highlightTextInLabel(
        textToSetup: UILabel,
        textToHighlight: String,
        color: AppColor,
        font: AppFont
    ) {
        let textConfig = NSMutableAttributedString(string: textToSetup.text ?? .init())
        let rangeToHighlight = textConfig.mutableString.range(of: textToHighlight, options: .caseInsensitive)
        var attributes: [NSAttributedString.Key: Any] = [:]
        
        attributes[.font] = font.value
        attributes[.foregroundColor] = color.value
        textConfig.addAttributes(attributes, range: rangeToHighlight)
        textToSetup.attributedText = textConfig
    }
    
    static func setupTapGesture(target: Any, textToSetup: UILabel, onTapAction: Selector) {
        textToSetup.isUserInteractionEnabled = true
        textToSetup.addGestureRecognizer(UITapGestureRecognizer(target: target, action: onTapAction))
    }
}
