//
//  FavoriteCity.swift
//  MyBundle
//
//  Created by DAGUIN Sébastien on 03/05/2021.
//
import Foundation
import CoreData
class FavoriteCity : NSManagedObject {
   
    static var all : [FavoriteCity] {
        let request : NSFetchRequest<FavoriteCity> = FavoriteCity.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "nameOfFlag" , ascending: true),
            NSSortDescriptor(key: "nameFavoriteCity", ascending: true)
        ]
        guard let favoriteCitys = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return favoriteCitys
    }
}
