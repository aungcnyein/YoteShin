//
//  GridContent+Post.swift
//  YoteShin
//
//  Created by Aung Chan Nyein on 12/11/21.
//

import Foundation
import CodyFire

extension GridContentController {
    
    struct GridContentRequest: JSONPayload {
        let route: String
        let payload: GridContentPayload
        
        init(route: String = "viu", payload: GridContentPayload) {
            self.route = route
            self.payload = payload
        }
    }
    
    struct GridContentResponse: Codable {
        let status: Int
        let message: String
        let data: [Content]
    }
    
    static func get(_ request: GridContentController.GridContentRequest) -> APIRequest<GridContentResponse> {
        return APIRequest("exec").payload(request).method(.post)
    }
    
}
