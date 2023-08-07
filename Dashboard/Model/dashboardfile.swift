//
//  dashboardfile.swift
//  iOSArchitecture_MVVM
//
//  Created by Chetan Singh Negi on 18/07/23.
//  Copyright © 2023 Surjeet Singh. All rights reserved.
//
import Foundation
import UIKit

final class dashboardfile: Codable {
    var status: String
    var messageID: Int?
    var message: String?
    var data: Int?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case messageId = "messageId" // Corrected the spelling here
        case message = "message"
        case data = "data"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        status = try values.decodeIfPresent(String.self, forKey: .status)!
        messageID = try values.decodeIfPresent(Int.self, forKey: .messageId)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(Int.self, forKey: .data)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(status, forKey: .status)
        try container.encodeIfPresent(messageID, forKey: .messageId)
        try container.encodeIfPresent(message, forKey: .message)
        try container.encodeIfPresent(data, forKey: .data)
    }
    
    
}
