//
//  Webservice.swift
//  Hunger
//
//  Created by Sebastian Mejia on 2/10/21.
//

import Foundation

final class WebService {
    
    //MARK: -Properties
    private let serverEndpoint = "https://apinodejsmonty.herokuapp.com"
    
    func fetchMessages(
        onFinished: @escaping ([Message]) ->Void
    ) {
        guard let urlMessage = URL(string: "\(serverEndpoint)\(Endpoints.getMessages.url)") else {
            return
        }
        URLSession.shared.dataTask(
            with: urlMessage,
            completionHandler: { data, response, error in
                
                if error != nil {
                    guard let httpResponse = response as? HTTPURLResponse,
                          (200...299).contains(httpResponse.statusCode) else {
                        print(error)
                        return
                    }
                    return
                }
                guard let dataFromService = data else{
                    return
                }
                do{
                    let info = try JSONDecoder().decode(MessageResponse.self, from: dataFromService)
                    onFinished(info.body)
                }catch let errorCatch{
                    print(errorCatch)
                }
            }).resume()
    }
}

