//
//  Translate.swift
//  MyBundle
//
//  Created by DAGUIN Sébastien on 28/04/2021.
//

import Foundation
struct TextTranslated : Decodable {
    let translatedText : String
    let detectedSourceLanguage : String
}

struct Translation : Decodable {
    let translations : [TextTranslated]
}
struct TranslateData : Decodable{
    let data : Translation
}
