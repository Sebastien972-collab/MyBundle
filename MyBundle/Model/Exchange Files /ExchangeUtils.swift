//
//  ExchangeUtils.swift
//  ExchangeUtils
//
//  Created by DAGUIN Sébastien on 21/07/2021.
//

import Foundation

struct ExchangeUtils {
    
    static func reverseRate(rate : Double) -> Double {
        return  1 / rate
    }
    static func convertAmount(amount : Double, rate : Double) -> Double {
        let amountConvert = amount * rate
        return KitSdHelpers.roundedValue(value: amountConvert)
    }
}
