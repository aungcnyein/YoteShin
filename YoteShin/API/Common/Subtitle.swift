//
//  Subtitle.swift
//  YoteShin
//
//  Created by Aung Chan Nyein on 12/10/21.
//

import Foundation
import CodyFire

struct Subtitle: Codable {
    let language, displayLanguage, languageURL: String
    
    enum CodingKeys: String, CodingKey {
        case language = "language"
        case displayLanguage = "display_language"
        case languageURL = "language_url"
    }
}
