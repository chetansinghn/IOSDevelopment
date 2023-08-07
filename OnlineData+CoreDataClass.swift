//
//  OnlineData+CoreDataClass.swift
//  
//
//  Created by Chetan Singh Negi on 29/07/23.
//
//

import Foundation
import CoreData

@objc(OnlineData)
public class OnlineData: NSManagedObject {
    
    
        func addOnlineData(careerConsultationlabel : String , sessionLabel : String, aliquaLabel: String, economicsNatureLabel: String ) {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}

            let managedContext = appDelegate.persistentContainer.viewContext

            let onlineEntity = NSEntityDescription.entity(forEntityName: "OnlineData", in: managedContext)!

            let onlineObject = NSManagedObject(entity: onlineEntity, insertInto: managedContext)
            onlineObject.setValue(careerConsultationlabel, forKey: "aliquaData")
            onlineObject.setValue(sessionLabel, forKey: "careerConsultationData")
            onlineObject.setValue(aliquaLabel, forKey: "economicsData")
            onlineObject.setValue(economicsNatureLabel, forKey: "sessionStartedData")


            do{
                try
                managedContext.save()
                print("Success")

            } catch let error as NSError {
                print("Failed to save", error.localizedDescription)
            }
        }
    
    
    
    
}
