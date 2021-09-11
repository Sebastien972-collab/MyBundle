//
//  KitSdHelpers.swift
//  FirstSDF
//
//  Created by DAGUIN Sébastien on 13/07/2021.
//

import Foundation
public struct KitSdHelpers {
    public init(){}
    
    public static func roundedValue(value : Double) -> Double {
        return Double(round(100 * value) / 100)
    }
    public static func integerConvert(value : Double ) -> Int {
        return Int(value)
    }
}
