//
//  Playlist+Post.swift
//  YoteShin
//
//  Created by Aung Chan Nyein on 12/18/21.
//

import Foundation
import CodyFire

extension PlaylistContentController {
    
    struct PlaylistRequest: JSONPayload {
        let route: String
        let payload: PlaylistPayload
        
        init(route: String = "viu", payload: PlaylistPayload) {
            self.route = route
            self.payload = payload
        }
    }
    
    struct PlaylistResponse: Codable {
        let status: Int
        let message: String
        let data: PlaylistContents
    }
    
    struct PlaylistContents: Codable {
        let title: String
        let total: Int
        let content: [Content]
        
        enum CodingKeys: String, CodingKey {
            case title = "title"
            case total = "total"
            case content = "playlist_list"
        }
    }
    
    static func get(_ request: PlaylistRequest) -> APIRequest<PlaylistResponse> {
        return APIRequest("exec").payload(request).method(.post).responseTimeout(5)
    }
    
}
