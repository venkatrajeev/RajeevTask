//
//  NSDictionary+Extension.swift
//  Rajeev_Task
//
//  Created by Gemini on 7/20/18.
//  Copyright © 2018 Gemini. All rights reserved.
//

import Foundation

extension Dictionary {
    
    func removeNull() -> Dictionary {
        let mainDict = NSMutableDictionary.init(dictionary: self)
        for _dict in mainDict {
            if _dict.value is NSNull {
                mainDict.removeObject(forKey: _dict.key)
            }
            if _dict.value is NSDictionary {
                let test1 = (_dict.value as! NSDictionary).filter({ $0.value is NSNull }).map({ $0 })
                let mutableDict = NSMutableDictionary.init(dictionary: _dict.value as! NSDictionary)
                for test in test1 {
                    mutableDict.removeObject(forKey: test.key)
                }
                mainDict.removeObject(forKey: _dict.key)
                mainDict.setValue(mutableDict, forKey: _dict.key as? String ?? "")
            }
            if _dict.value is NSArray {
                let mutableArray = NSMutableArray.init(object: _dict.value)
                for (index,element) in mutableArray.enumerated() where element is NSDictionary {
                    let test1 = (element as! NSDictionary).filter({ $0.value is NSNull }).map({ $0 })
                    let mutableDict = NSMutableDictionary.init(dictionary: element as! NSDictionary)
                    for test in test1 {
                        mutableDict.removeObject(forKey: test.key)
                    }
                    mutableArray.replaceObject(at: index, with: mutableDict)
                }
                mainDict.removeObject(forKey: _dict.key)
                mainDict.setValue(mutableArray, forKey: _dict.key as? String ?? "")
            }
        }
        return mainDict as! Dictionary<Key, Value>
    }
    
    /*
     This is used to remove the null values from the response, to avoid crashes.
     */
     func removeNullValues(_ jsonDict: [AnyHashable: Any]) -> [AnyHashable: Any] {
        var nullValuesRemoveDict = jsonDict as! [String:Any]
        for key: String in nullValuesRemoveDict.keys {
            if (nullValuesRemoveDict[key] is NSNull) {
                nullValuesRemoveDict[key] = ""
            }
        }
        return nullValuesRemoveDict
    }
//    func nullKeyRemoval() -> Dictionary {
//        var dict = self
//        
//        let keysToRemove = Array(dict.keys).filter { dict[$0] is NSNull }
//        for key in keysToRemove {
//            dict.removeValue(forKey: key)
//        }
//        
//        return dict
//    }
}
