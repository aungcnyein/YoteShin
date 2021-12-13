//
//  MovieContent+Post.swift
//  YoteShin
//
//  Created by Aung Chan Nyein on 12/10/21.
//

import Foundation
import CodyFire

extension MovieContentController {
    
    struct MovieContentRequest: JSONPayload {
        let route: String
        let payload: MovieContentPayload

        init(route: String = "viu", payload: MovieContentPayload) {
            self.route = route
            self.payload = payload
        }
    }
    
    struct MovieContentResponse: Codable {
        let status: Int
        let message: String
        let data: [MovieContents]
    }
    
    struct MovieContents: Codable {
        let id, title: String
        let description: String?
        let content: [Content]
        
        enum CodingKeys: String, CodingKey {
            case id = "id"
            case title = "title"
            case description = "description"
            case content = "video_list"
        }
    }
    
    static func get(_ request: MovieContentRequest) -> APIRequest<MovieContentResponse> {
        return APIRequest("exec").payload(request).method(.post).responseTimeout(5)
    }
    
}
