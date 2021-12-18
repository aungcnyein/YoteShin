//
//  EpisodeContent.swift
//  YoteShin
//
//  Created by Aung Chan Nyein on 12/15/21.
//

import Foundation

struct EpisodeContent: Codable {
    let episodeID: String
    let episodeTitle, episodeDescription, episodeCover, episodeURL: String
    let episodeSubtitle: [Subtitle]
    
    enum CodingKeys: String, CodingKey {
        case episodeID = "episode_id"
        case episodeTitle = "episode_title"
        case episodeDescription = "episode_description"
        case episodeCover = "episode_cover"
        case episodeURL = "episode_url"
        case episodeSubtitle = "episode_subtitle"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        episodeTitle = try container.decode(String.self, forKey: .episodeTitle)
        episodeDescription = try container.decode(String.self, forKey: .episodeDescription)
        episodeCover = try container.decode(String.self, forKey: .episodeCover)
        episodeURL = try container.decode(String.self, forKey: .episodeURL)
        episodeSubtitle = try container.decode([Subtitle].self, forKey: .episodeSubtitle)
        
        do {
            episodeID = try String(container.decode(Int.self, forKey: .episodeID))
        } catch DecodingError.typeMismatch {
            episodeID = try container.decode(String.self, forKey: .episodeID)
        }
    }
}
