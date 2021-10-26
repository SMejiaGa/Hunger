//
//  RoundTextField.swift
//  Hunger
//
//  Created by Sebastian Mejia on 20/10/21.
//

import Foundation
import UIKit

class RoundTextField: UITextField {
    @IBInspectable var cornerRadius: CGFloat = 4
    
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
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.borderColor = UIColor(named: "GrayForBorders")?.cgColor
        layer.borderWidth = 1.5
    }
}
