//
//  ContentListingRouter.swift
//  ContentListing
//
//  Created by Aung Chan Nyein on 12/10/21.
//

import Foundation
import UIKit

final class ContentListingRouter: RouterInterface {

    weak var presenter: ContentListingPresenterRouterInterface!

    weak var viewController: UIViewController?
}

extension ContentListingRouter: ContentListingRouterPresenterInterface {

    func goToContentDetailView(content: Content, type: ContentType, shouldEmbedNavigation: Bool) {
        let view = ContentDetailModule().build(content: content, type: type)
        
        if shouldEmbedNavigation {
            viewController?.present(UINavigationController(rootViewController: view), animated: true, completion: nil)
        } else {
            viewController?.navigationController?.pushViewController(view, animated: true)
        }
    }
    
}
