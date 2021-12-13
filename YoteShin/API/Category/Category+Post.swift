//
//  Category+Get.swift
//  YoteShin
//
//  Created by Aung Chan Nyein on 11/17/21.
//

import Foundation
import CodyFire

extension CategoryController {
    
    struct CategoryRequest: JSONPayload {
        let route: String
        let payload: CategoryPayload

        init(route: String = "viu", payload: CategoryPayload) {
            self.route = route
            self.payload = payload
        }
    }
    
    struct CategoryResponse: Codable {
        let status: Int
        let message: String
        let data: [Categories]
    }
    
    struct Categories: Codable {
        let key: String
        let title: String
        let type: String
        
        enum CodingKeys: String, CodingKey {
            case key = "drawer_key"
            case title = "drawer_title"
            case type = "drawer_type"
        }
    }
    
    static func get(_ request: CategoryRequest) -> APIRequest<CategoryResponse> {
        return APIRequest("exec").payload(request).method(.post).responseTimeout(5)
    }
    
}
