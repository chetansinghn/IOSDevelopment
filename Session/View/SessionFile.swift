//
//  SessionView.swift
//  iOSArchitecture_MVVM
//
//  Created by Chetan Singh Negi on 21/07/23.
//  Copyright © 2023 Surjeet Singh. All rights reserved.
//
//
import Foundation

struct SessionFile: Codable {
    let status: String?
    let messageID: Int?
    let message: String?
    let data: DataClass?

    enum CodingKeys: String, CodingKey {
        case status = "status"
         case messageID = "messageID"
          case message = "message"
          case  data = "data"
       
    }

     init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        messageID = try values.decodeIfPresent(Int.self, forKey: .messageID)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(DataClass.self, forKey: .data)

    }
}




struct DataClass: Codable {
    let docs: [Doc]?
    
    
    enum CodingKeys: String, CodingKey {
        case docs = "docs"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        docs = try values.decodeIfPresent([Doc].self, forKey: .docs)
    }
}




struct Doc: Codable {
    let id: String?
    let session_name: String?
    let start_date: String?
    let time: String?
    let location: String?
    let description: String?
        let sessionData: SessionData?
        let category_data: [CategoryDatum]?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case session_name = "session_name"
        case start_date = "start_date"
        case time = "time"
        case location = "location"
        case description = "description"
            case sessionData = "session_data"
            case category_data = "category_data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        id = try values.decodeIfPresent(String.self, forKey: .id)
        session_name = try values.decodeIfPresent(String.self, forKey: .session_name)
        start_date = try values.decodeIfPresent(String.self, forKey: .start_date)
        time = try values.decodeIfPresent(String.self, forKey: .time)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        sessionData = try values.decodeIfPresent(SessionData.self, forKey: .sessionData)
        category_data = try values.decodeIfPresent([CategoryDatum].self, forKey: .category_data) ?? []
    }
}





struct SessionData: Codable {
    let mentorship_name: String?
    let description: String?
    enum CodingKeys: String, CodingKey {
    case mentorship_name = "mentorship_name"
    case  description = "description"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.mentorship_name = try container.decodeIfPresent(String.self, forKey: .mentorship_name)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
      
    }
}



struct CategoryDatum: Codable {
    let categoryName: String
    let image: String

    enum CodingKeys: String, CodingKey {
        case categoryName = "categoryName"
        case image = "image"

    }
                    init(from decoder: Decoder) throws {
                   let container = try decoder.container(keyedBy: CodingKeys.self)

                    self.categoryName = try container.decode(String.self, forKey: .categoryName )
                   
                        self.image = try container.decode(String.self, forKey: .image)

               }
           }









