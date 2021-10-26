//
//  TextUtils.swift
//  Hunger
//
//  Created by Sebastian Mejia on 22/10/21.
//

import Foundation
import UIKit

class TextUtils {
    static func highlightTextInLabel(
        textToSetup: UILabel,
        textToHighlight: String,
        color: AppColor,
        font: AppFont
    ) {
        let textConfig = NSMutableAttributedString(string: textToSetup.text ?? "")
        let rangeToHighlight = textConfig.mutableString.range(of: textToHighlight, options: .caseInsensitive)
        var attributes: [NSAttributedString.Key: Any] = [:]
        
        attributes[.font] = font
        attributes[.foregroundColor] = color.value
        textConfig.addAttributes(attributes, range: rangeToHighlight)
        textToSetup.attributedText = textConfig
    }
    
    static func setupTapGesture(target: Any, textToSetup: UILabel, onTapAction: Selector) {
        textToSetup.isUserInteractionEnabled = true
        textToSetup.addGestureRecognizer(UITapGestureRecognizer(target: target, action: onTapAction))
    }
}
