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

    func goToContentDetailView(content: Content, type: ContentType) {
        let view = ContentDetailModule().build(content: content, type: type)
        viewController?.present(view, animated: true, completion: nil)
    }
    
}
