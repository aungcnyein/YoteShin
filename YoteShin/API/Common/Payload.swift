//
//  Payload.swift
//  YoteShin
//
//  Created by Aung Chan Nyein on 11/17/21.
//

import Foundation
import CodyFire

struct CategoryPayload: Codable {
    let subRoute: String
    
    enum CodingKeys: String, CodingKey {
        case subRoute = "sub_route"
    }
    
    init(subRoute: String = "drawerMenu") {
        self.subRoute = subRoute
    }
}

struct MovieContentPayload: Codable {
    let subRoute: String
    let categoryKey: String
    
    enum CodingKeys: String, CodingKey {
        case subRoute = "sub_route"
        case categoryKey = "drawer_key"
    }
    
    init(subRoute: String = "drawerDetail", categoryKey: String) {
        self.subRoute = subRoute
        self.categoryKey = categoryKey
    }
}

struct GridContentPayload: Codable {
    let subRoute: String
    let categoryKey: String
    let page: Int
    
    enum CodingKeys: String, CodingKey {
        case subRoute = "sub_route"
        case categoryKey = "category_id"
        case page = "page"
    }
    
    init(subRoute: String = "videoListByCategoryID", categoryKey: String, page: Int) {
        self.subRoute = subRoute
        self.categoryKey = categoryKey
        self.page = page
    }
}

struct EpisodeContentListPayload: Codable {
    let subRoute: String
    let videoId: String
    let page: Int
    
    enum CodingKeys: String, CodingKey {
        case subRoute = "sub_route"
        case videoId = "video_id"
        case page = "page"
    }
    
    init(subRoute: String = "videoEpisodeList", videoId: String, page: Int) {
        self.subRoute = subRoute
        self.videoId = videoId
        self.page = page
    }
}

struct RelatedContentListPayload: Codable {
    let subRoute: String
    let videoId: String
    
    enum CodingKeys: String, CodingKey {
        case subRoute = "sub_route"
        case videoId = "video_id"
    }
    
    init(subRoute: String = "videoRelatedList", videoId: String) {
        self.subRoute = subRoute
        self.videoId = videoId
    }
}

struct PlaylistPayload: Codable {
    let subRoute: String
    let playlistId: String
    let page: Int
    
    enum CodingKeys: String, CodingKey {
        case subRoute = "sub_route"
        case playlistId = "playlist_id"
        case page = "page"
    }
    
    init(subRoute: String = "videoPlaylistList", playlistId: String, page: Int) {
        self.subRoute = subRoute
        self.playlistId = playlistId
        self.page = page
    }
}
