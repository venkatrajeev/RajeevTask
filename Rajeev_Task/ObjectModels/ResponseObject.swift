//
//  ResponseObject.swift
//  Rajeev_Task
//
//  Created by Gemini on 7/20/18.
//  Copyright © 2018 Gemini. All rights reserved.
//

import UIKit

class ResponseObject: NSObject {

    var titleString = String()
    var descriptionString = String()
    var pictureString = String()
 
    init(ResponseDictionary:[String:Any]) {
        let factsNullDictionary =  HelperClass.removeNullValues(ResponseDictionary)
        context.performAndWait ({
            let factsVariables = Facts(context: context)
            factsVariables.factsTitle = factsNullDictionary["title"] as? String
            factsVariables.factsDescription = factsNullDictionary["description"] as? String
            factsVariables.factsImage = factsNullDictionary["imageHref"] as? String
            do {
                try context.save()
            } catch {
            }
 })
    }
}
