//
//  HButton.swift
//  Hunger
//
//  Created by Sebastian Mejia on 20/10/21.
//

import Foundation
import UIKit

class HButton: RoundButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        titleLabel?.font = UIFont(name: "SourceSansPro-Bold", size: 15)
        
        titleLabel?.attributedText = NSMutableAttributedString(
            string: titleLabel?.text ?? "",
            attributes: [NSAttributedString.Key.kern: 1.2]
        )
    }
}
