//
//  TranslateLangageAvailable.swift
//  MyBundle
//
//  Created by DAGUIN Sébastien on 20/05/2021.
//

import Foundation
struct LanguageAvailable {
    static let language : [Language] = [Language(bcpcode47: "af", langage: "Afrikaans", script: .latin),
                                                Language(bcpcode47: "ar", langage: "Arabic", script: .arabic),
                                                Language(bcpcode47: "ar-Latn ", langage: "Arabic", script: .latin),
                                                Language(bcpcode47: "be", langage: "Belarusian", script: .cyrillic),
                                                Language(bcpcode47: "bg", langage: "Bulgarian", script: .cyrillic),
                                                Language(bcpcode47: "bg-Latin", langage: "Bulgarian", script: .cyrillic),
                                                Language(bcpcode47: "bn", langage: "Bengali", script: .bengali),
                                                Language(bcpcode47: "bs", langage: "Bosnian", script: .latin),
                                                Language(bcpcode47: "ca", langage: "Catalan", script: .latin),
                                                Language(bcpcode47: "fr", langage: "French", script: .latin),
                                                Language(bcpcode47: "ga", langage: "Irish", script: .latin),
                                                Language(bcpcode47: "ht", langage: "Haitian", script: .latin),
                                                Language(bcpcode47: "it", langage: "Italien", script: .latin),
                                                Language(bcpcode47: "la", langage: "Latin", script: .latin),
                                                Language(bcpcode47: "en", langage: "English", script: .latin),
                                                Language(bcpcode47: "es", langage: "Spanish", script: .latin),
                                                Language(bcpcode47: "ja", langage: "Japanese", script: .japanese)
                                               
                                               
]
    static func detectLanguage(bcpcode47 : String) -> Language {
        for language in LanguageAvailable.language{
            if language.bcpcode47 == bcpcode47 {
                return language
            }
        }
        return LanguageAvailable.language[0]
    }
    
}
