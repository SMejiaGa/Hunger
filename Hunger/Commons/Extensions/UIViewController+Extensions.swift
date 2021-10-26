//
//  UIViewController+Extensions.swift
//  Hunger
//
//  Created by Sebastian Mejia on 18/10/21.
//

import Foundation
import UIKit
import Dodo

extension UIViewController {
    
    func showMessage(alertMessage: String, backgroundColorHex: String = "#49568E") {
        view.dodo.topAnchor = view.safeAreaLayoutGuide.topAnchor
        view.dodo.bottomAnchor = view.safeAreaLayoutGuide.bottomAnchor
        view.dodo.style.bar.backgroundColor = DodoColor.fromHexString(backgroundColorHex)
        view.dodo.style.leftButton.icon = .close
        view.dodo.style.leftButton.hideOnTap = true
        view.dodo.info(alertMessage)
    }
}
