//
//  ContentListingType.swift
//  YoteShin
//
//  Created by Aung Chan Nyein on 12/11/21.
//

import Foundation

enum ContentListingType: String, CaseIterable, CustomStringConvertible {
    case list // It means movie content
    case grid // It means grid content
    
    var description: String {
        switch self {
        case .list: return "list"
        case .grid: return "grid"
        }
    }
    
}
