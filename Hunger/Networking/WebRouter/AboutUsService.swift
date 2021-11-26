//
//  LegalService.swift
//  Hunger
//
//  Created by Sebastian Mejia on 24/11/21.
//

import Foundation
import Alamofire

typealias LegalResult = (LegalResponse, Bool) -> Void

final class AboutUsService {
    
    func getLegal(onFinished: @escaping LegalResult) {
        
        var errorExist: Bool = false
   
        AF.request(Endpoints.getLegalText.url).responseDecodable { (res: DataResponse<LegalResponse, AFError>) in
            if res.error != nil {
                errorExist = true
            }
            if let responseFromService = res.value {
                onFinished(responseFromService, errorExist)
            }
        }
    }
}
extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(
                data: data,
                options: [.documentType: NSAttributedString.DocumentType.html,
                          .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
