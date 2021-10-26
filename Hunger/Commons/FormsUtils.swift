//
//  FormsUtils.swift
//  Hunger
//
//  Created by Sebastian Mejia on 18/10/21.
//

import Foundation

class FormsUtils {
     static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
