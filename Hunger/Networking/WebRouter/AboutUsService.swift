//
//  AboutUsService.swift
//  Hunger
//
//  Created by Sebastian Mejia on 24/11/21.
//

import Foundation
import Alamofire

typealias AboutUsResult = (AboutUsResponse, Bool) -> Void

final class AboutUsService {
    
    func getAboutUs(onFinished: @escaping AboutUsResult) {
   
        AF.request(Endpoints.getAboutUsText.url).responseDecodable { (res: DataResponse<AboutUsResponse, AFError>) in
            if let responseFromService = res.value {
                onFinished(responseFromService, (res.error != nil))
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
        } catch let error{
            print(error)
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
