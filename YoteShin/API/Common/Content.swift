//
//  Content.swift
//  YoteShin
//
//  Created by Aung Chan Nyein on 12/10/21.
//

import Foundation
import CodyFire

struct Content: Codable {
    let movieID: String
    let playlistID, movieTitle, movieDescription, moviePoster, movieCover, movieURL, movieCompanyName, movieContentType: String
    let movieSubtitles: [Subtitle]?
    let movieEpisodeTotal: Int

    enum CodingKeys: String, CodingKey {
        case movieID = "video_id"
        case playlistID = "playlist_id"
        case movieTitle = "video_title"
        case movieDescription = "video_description"
        case moviePoster = "video_poster"
        case movieCover = "video_cover"
        case movieURL = "video_url"
        case movieSubtitles = "video_subtitles"
        case movieCompanyName = "video_company_name"
        case movieContentType = "video_content_type"
        case movieEpisodeTotal = "video_episode_total"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        playlistID = try container.decode(String.self, forKey: .playlistID)
        movieTitle = try container.decode(String.self, forKey: .movieTitle)
        movieDescription = try container.decode(String.self, forKey: .movieDescription)
        moviePoster = try container.decode(String.self, forKey: .moviePoster)
        movieCover = try container.decode(String.self, forKey: .movieCover)
        movieURL = try container.decode(String.self, forKey: .movieURL)
        movieCompanyName = try container.decode(String.self, forKey: .movieCompanyName)
        movieContentType = try container.decode(String.self, forKey: .movieContentType)
        movieSubtitles = try container.decode([Subtitle].self, forKey: .movieSubtitles)
        movieEpisodeTotal = try container.decode(Int.self, forKey: .movieEpisodeTotal)

        do {
            movieID = try String(container.decode(Int.self, forKey: .movieID))
        } catch DecodingError.typeMismatch {
            movieID = try container.decode(String.self, forKey: .movieID)
        }
    }
}
