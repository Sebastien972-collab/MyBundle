//
//  Langue.swift
//  MyBundle
//
//  Created by DAGUIN Sébastien on 20/05/2021.
//

import Foundation
struct Language {
    let bcpcode47 : String
    let langage : String
    let script : Script
    
    static let defaultLanguage = Language(bcpcode47: "fr", langage: "French", script: .latin)
    static let defaultAutoLanguage = Language(bcpcode47: "", langage: "Auto", script: .auto)
    
}
enum Script {
    case latin,
         armenian,
         japanese,
         georgian,
         malayalam,
         devanagari,
         myanmar,
         gurmukhi,
         Sinhala,
         english,
         tamil,
         Thai,
         Chinese,
         telugu,
         geez,
         arabic,
         cyrillic,
         bengali,
         Greek,
         Gujarati,
         Hebrew,
         auto
    
}
enum LanguageTranslationDirection {
    case fromLanguage, toLangage
}
