//
//  OnlineData+CoreDataProperties.swift
//  
//
//  Created by Chetan Singh Negi on 29/07/23.
//
//

import Foundation
import CoreData


extension OnlineData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OnlineData> {
        return NSFetchRequest<OnlineData>(entityName: "OnlineData")
    }

    @NSManaged public var aliquaData: String?
    @NSManaged public var careerConsultationData: String?
    @NSManaged public var economicsData: String?
    @NSManaged public var sessionStartedData: String?

}
