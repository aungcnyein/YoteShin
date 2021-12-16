//
//  ContentDetailRouter.swift
//  ContentDetail
//
//  Created by Aung Chan Nyein on 12/13/21.
//

import Foundation
import UIKit

final class ContentDetailRouter: RouterInterface {

    weak var presenter: ContentDetailPresenterRouterInterface!

    weak var viewController: UIViewController?
}

extension ContentDetailRouter: ContentDetailRouterPresenterInterface {

    func addContentListingView(at containerView: UIView, with content: Content) {
        let categorizedContent = CategorizedContent(content: content)
        
        ViewEmbedder.addChild(
            childController: ContentListingModule().build(categorizedContent: categorizedContent, type: .contentDetail),
            parentController: viewController!,
            containerView: containerView
        )
    }
    
    func addContentDescriptionView(at containerView: UIView, with content: Content) {
        ViewEmbedder.addChild(
            childController: ContentDescriptionModule().build(content: content),
            parentController: viewController!,
            containerView: containerView
        )
    }
    
    func addEpisodeContentListingView(at containerView: UIView, with content: Content) {
        ViewEmbedder.addChild(
            childController: EpisodeContentListingModule().build(content: content),
            parentController: viewController!,
            containerView: containerView
        )
    }
    
}
