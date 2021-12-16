//
//  ContentType.swift
//  YoteShin
//
//  Created by Aung Chan Nyein on 12/15/21.
//

import Foundation

enum ContentType: String, CaseIterable, CustomStringConvertible {
    case movie
    case episode
    
    var description: String {
        switch self {
        case .movie: return "movie"
        case .episode: return "episode"
        }
    }
}
