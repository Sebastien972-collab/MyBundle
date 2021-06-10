//
//  TempsFavorite.swift
//  MyBundle
//
//  Created by DAGUIN Sébastien on 26/05/2021.
//

import Foundation
enum FavoriteTemps : String, CaseIterable, Identifiable {
    var id : String{self.rawValue}
    case veryHot
    case hot
    case normal
    case cold
    case veryCold
}
