//
//  Facts+CoreDataProperties.swift
//  Rajeev_Task
//
//  Created by Gemini on 7/20/18.
//  Copyright © 2018 Gemini. All rights reserved.
//
//

import Foundation
import CoreData

extension Facts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Facts> {
        return NSFetchRequest<Facts>(entityName: "Facts")
    }

    @NSManaged public var factsTitle: String?
    @NSManaged public var factsDescription: String?
    @NSManaged public var factsImage: String?

}
