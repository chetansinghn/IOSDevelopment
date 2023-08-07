/* 
Copyright (c) 2018 smartData

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
import UIKit

final class User: Codable {
    
    var status : String?
    var messageId : Int?
    var message : String?
    var data: LoginData?
    
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case messasgeId = "messageId"
        case message = "message"
        case data = "data"
        
    }
    
   
    
    required init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        messageId = try values.decodeIfPresent(Int.self, forKey: .messasgeId)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(LoginData.self, forKey: .data)
     
    }
}

struct LoginData : Codable{
    
    let _id : String?
    let name : String?
    let email : String?
    let role : String?
    let password : String?
    let image : String?
    let myreferalcode : String?
    let token : String?
    
    
    enum CodingKeys: String, CodingKey{
        
        case _id = "_id"
        case name = "name"
        case email = "email"
        case role = "role"
        case password = "password"
        case image = "image"
        case myreferalcode = "myreferalcode"
        case token = "token"
        
    }
    
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        role = try values.decodeIfPresent(String.self, forKey: .role)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        image = try values.decodeIfPresent(String.self, forKey:  .image)
        myreferalcode = try values.decodeIfPresent(String.self, forKey: .myreferalcode)
        token = try values.decodeIfPresent(String.self, forKey: .token)
    }
}











































///**
//    Returns an array of models based on given dictionary.
//
//    Sample usage:
//    let user = User.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
//
//    - parameter array:  Array from JSON dictionary.
//
//    - returns: Array of User Instances.
//*/
//    public class func modelsFromDictionaryArray(array:Array<Dictionary<String,Any>>) -> [User]
//    {
//        var models:[User] = []
//        for item in array
//        {
//            if let model = User(dictionary: item) {
//                models.append(model)
//            }
//        }
//        return models
//    }
//
///**
//    Constructs the object based on the given dictionary.
//
//    Sample usage:
//    let user = User(someDictionaryFromJSON)
//
//    - parameter dictionary:  Dictionary<String,Any> from JSON.
//
//    - returns: User Instance.
//*/
//    required public init?(dictionary: Dictionary<String,Any>) {
//
//        name = dictionary["name"] as? String ?? ""
//        email = dictionary["email"] as? String ?? ""
//        id = dictionary["id"] as? Int ?? 0
//        pasword = dictionary["pasword"] as? String ?? ""
//    }
//
//
///**
//    Returns the dictionary representation for the current instance.
//
//    - returns: NSDictionary.
//*/
//    public func dictionaryRepresentation() -> Dictionary<String,Any> {
//
//        var dictionary = Dictionary<String,Any>()
//
//        dictionary["name"] = self.name
//        dictionary["email"] = self.email
//        dictionary["id"] = self.id
//        dictionary["pasword"] = self.pasword
//
//        return dictionary
//    }
