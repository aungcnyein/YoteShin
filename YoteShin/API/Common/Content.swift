//
//  Content.swift
//  YoteShin
//
//  Created by Aung Chan Nyein on 12/10/21.
//

import Foundation
import CodyFire

struct Content: Codable {
    let playlistID, movieTitle, movieDescription: String
    let moviePoster, movieCover: String
    let movieURL: String
    let movieSubtitles: [Subtitle]?
    let movieCompanyName, movieContentType: String
    let movieEpisodeTotal: Int

    enum CodingKeys: String, CodingKey {
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
}
