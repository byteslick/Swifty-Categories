//
//  HashMap+Extension.swift
///  SwiftyCategories
//
//  Created by Madhup Yadav on 18/09/19.
//


import UIKit

public typealias JDictionary = [String:Any]

public extension JDictionary{
    
    func value(_ keys: String...) -> Any?{
        var startIndex = 0
        let endIndex = (keys.count - 1)
        var dictToItrate:[String:Any]? = self
        for key in keys{
            if startIndex == endIndex{
                return dictToItrate?[key]
            }else{
                if dictToItrate?[key] != nil,
                    let object = dictToItrate?[key] as? [String:Any]{
                    dictToItrate = object
                    startIndex += 1
                }
            }
        }
        return nil
    }
}
