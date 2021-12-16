//
//  RelatedContent+Post.swift
//  YoteShin
//
//  Created by Aung Chan Nyein on 12/14/21.
//

import Foundation
import CodyFire

extension RelatedContentController {
    
    struct RelatedContentRequest: JSONPayload {
        let route: String
        let payload: RelatedContentListPayload
        
        init(route: String = "viu", payload: RelatedContentListPayload) {
            self.route = route
            self.payload = payload
        }
    }
    
    struct RelatedContentResponse: Codable {
        let status: Int
        let message: String
        let data: RelatedContents
    }
    
    struct RelatedContents: Codable {
        let title: String
        let total: Int
        let content: [Content]
        
        enum CodingKeys: String, CodingKey {
            case title = "title"
            case total = "total"
            case content = "related_list"
        }
    }
    
    static func get(_ request: RelatedContentRequest) -> APIRequest<RelatedContentResponse> {
        return APIRequest("exec").payload(request).method(.post).responseTimeout(5)
    }
    
}
