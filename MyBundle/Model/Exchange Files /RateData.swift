//
//  RateData.swift
//  MyBundle
//
//  Created by DAGUIN Sébastien on 14/06/2021.
//

import Foundation
struct RateData : Codable {
    var base : String
    var date : String
    var rates : [String : Double]
    
}
