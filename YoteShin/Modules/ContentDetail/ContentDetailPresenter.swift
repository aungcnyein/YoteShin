//
//  ContentDetailPresenter.swift
//  ContentDetail
//
//  Created by Aung Chan Nyein on 12/13/21.
//

import Foundation
import UIKit

final class ContentDetailPresenter: PresenterInterface {

    var router: ContentDetailRouterPresenterInterface!
    var interactor: ContentDetailInteractorPresenterInterface!
    weak var view: ContentDetailViewPresenterInterface!

}

extension ContentDetailPresenter: ContentDetailPresenterRouterInterface {

}

extension ContentDetailPresenter: ContentDetailPresenterInteractorInterface {

}

extension ContentDetailPresenter: ContentDetailPresenterViewInterface {
    
    func embedContentListingView(at containerView: UIView, with content: Content) {
        router.addContentListingView(at: containerView, with: content)
    }
    
    func embedContentDescriptionView(at containerView: UIView, with content: Content) {
        router.addContentDescriptionView(at: containerView, with: content)
    }
    
    func embedEpisodeContentListingView(at containerView: UIView, with content: Content) {
        router.addEpisodeContentListingView(at: containerView, with: content)
    }
    
}
