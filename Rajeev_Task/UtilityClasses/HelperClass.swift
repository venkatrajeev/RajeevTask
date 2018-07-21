//
//  HelperClass.swift
//  Rajeev_Task
//
//  Created by Gemini on 7/20/18.
//  Copyright © 2018 Gemini. All rights reserved.
//

import UIKit

class HelperClass: NSObject {
    
    /*
     This is used to remove the null values from the response, to avoid crashes.
     */

    class func removeNullValues(_ jsonDict: [String: Any]) -> [String: Any] {
        var nullValuesRemoveDict = jsonDict 
        for key: String in nullValuesRemoveDict.keys {
            if (nullValuesRemoveDict[key] is NSNull) {
                nullValuesRemoveDict[key] = ""
            }
        }
        return nullValuesRemoveDict
    }
 
    /*
     This is global method is used to update the UI fields
     */
    class func updateLayer(onView view: UIView, borderColor color: UIColor, borderWidth width: CGFloat, cornerRadious radious: CGFloat) {
        view.layer.cornerRadius = radious
        view.layer.borderWidth = width
        view.layer.borderColor = color.cgColor
        view.layer.masksToBounds = true
    }
}
