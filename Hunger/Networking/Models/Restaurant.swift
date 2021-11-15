//
//  message.swift
//  Hunger
//
//  Created by Sebastian Mejia on 9/10/21.
//

import Foundation

struct Restaurant: Codable {
    let id: Int
    let distance: Int
    let isAvaliable: Bool
    let name: String
}


/*{
"address": "Calle 129 # 55-42",
"isOpen": false,
"rating": {
"average": 2.4832451343536377,
"max": 10
},
"id": 1,
"isFavorite": false,
"commentsCount": 57,
"stars": 2,
"name": "Restaurant 1"
}*/
