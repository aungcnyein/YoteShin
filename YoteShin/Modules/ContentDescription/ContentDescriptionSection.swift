//
//  ContentDescriptionSection.swift
//  YoteShin
//
//  Created by Aung Chan Nyein on 12/16/21.
//

import Foundation

struct ContentDescription {
    
    static var content: Content!

    enum ContentDescriptionSection: Int, CaseIterable, CustomStringConvertible {
        case title
        case companyName
        case type
        case episode
        
        var detail: String {
            switch self {
            case .title: return content.movieTitle
            case .companyName: return content.movieCompanyName
            case .type: return content.movieContentType
            case .episode: return String(content.movieEpisodeTotal)
            }
        }
        
        var description: String {
            switch self {
            case .title: return "Title"
            case .companyName: return "Company Name"
            case .type: return "Type"
            case .episode: return "Total Episode"
            }
        }
    }
    
}
