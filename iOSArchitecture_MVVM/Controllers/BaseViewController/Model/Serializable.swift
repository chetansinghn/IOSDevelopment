////
////  Serializable.swift
////  iOSArchitecture_MVVM
////
////  Created by shivani Bajaj on 9/24/19.
////  Copyright © 2019 Surjeet Singh. All rights reserved.
////
//
//import Foundation
//
//protocol Serializable: Codable {
//    func serialize() -> Data? // Converting a model object to json
//    func deserialize() -> Self.Type // Converting a json object to model
//}
//
//extension Serializable {
//    func serialize() -> Data? {
//        do {
//            return try JSONEncoder().encode(self)
//        } catch {
//            return nil
//        }
//    }
//    
//    func deserialize(from data: Data) -> Self.Type {
//        do {
//            return try JSONDecoder().decode(Self.Type, from: data)
//        } catch {
//            return nil
//        }
//    }
//}
