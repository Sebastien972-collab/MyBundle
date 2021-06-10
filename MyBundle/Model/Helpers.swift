//
//  Helpers.swift
//  MyBundle
//
//  Created by DAGUIN Sébastien on 10/06/2021.
//

import Foundation

struct Helpers {
    static func clearSpaceUrl(city : String) -> String {
        var cityArray = Array(city)
        var cityCleaned = city
        if city.contains(" ") {
            for (index,_) in cityArray.enumerated() {
                if cityArray[index] == " " {
                    cityArray[index] = "%"
                    cityArray.insert("2", at: index + 1)
                    cityArray.insert("0", at: index + 2)
                }
            }
            cityCleaned = String(cityArray)
        }
        return cityCleaned
    }
    static func recup(json : String) -> String {
        let arrayJson = json.split(separator: ",")
        var description = " "
        for (index, _) in arrayJson.enumerated() {
            if arrayJson[index].contains("description") {
                description = String(arrayJson[index])
                let descriptionToReturn = description.split(separator: ":")
                return String(descriptionToReturn[1])
            }
        }
        return description
    }
}
