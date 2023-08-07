//
//  UpdateModel.swift
//  iOSArchitecture_MVVM
//
//  Created by Chetan Singh Negi on 01/08/23.
//  Copyright © 2023 Surjeet Singh. All rights reserved.
//

import Foundation

struct UpdateModel: Codable {
    let status: String
    let messageID: Int
    let message: String

enum CodingKeys: String, CodingKey {
    case status = "status"
    case messageID = "messageID"
    case message = "message"
    
}
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)!
        messageID = try values.decodeIfPresent(Int.self, forKey: .messageID)!
        message = try values.decodeIfPresent(String.self, forKey: .message)!
        
    }
}
