//
//  EpisodeContent+Post.swift
//  YoteShin
//
//  Created by Aung Chan Nyein on 12/15/21.
//

import Foundation
import CodyFire

extension EpisodeContentController {
    
    struct EpisodeContentRequest: JSONPayload {
        let route: String
        let payload: EpisodeContentListPayload
        
        init(route: String = "viu", payload: EpisodeContentListPayload) {
            self.route = route
            self.payload = payload
        }
    }
    
    struct EpisodeContentResponse: Codable {
        let status: Int
        let message: String
        let data: [EpisodeContent]
    }
    
    static func get(_ request: EpisodeContentRequest) -> APIRequest<EpisodeContentResponse> {
        return APIRequest("exec").payload(request).method(.post)
    }
    
}
