//
//  ObjectManager.swift
//  Rajeev_Task
//
//  Created by Gemini on 7/20/18.
//  Copyright © 2018 Gemini. All rights reserved.
//

/*
    Handles the global access variable and  urls
 */

import UIKit

class ObjectManager: NSObject {
   
    private static var objectManagerSingleTone:ObjectManager?

    var isInternetAvailable:Bool?
    // URL
     var serviceURL:String = "http://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    
    static func sharedObjectManager()-> ObjectManager {
        if objectManagerSingleTone==nil {
            objectManagerSingleTone = ObjectManager()
        }
        return objectManagerSingleTone!
    }
}
