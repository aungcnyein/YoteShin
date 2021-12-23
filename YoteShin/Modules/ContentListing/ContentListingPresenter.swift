//
//  ContentListingPresenter.swift
//  ContentListing
//
//  Created by Aung Chan Nyein on 12/10/21.
//

import Foundation

final class ContentListingPresenter: PresenterInterface {

    var router: ContentListingRouterPresenterInterface!
    var interactor: ContentListingInteractorPresenterInterface!
    weak var view: ContentListingViewPresenterInterface!

}

extension ContentListingPresenter: ContentListingPresenterRouterInterface {

}

extension ContentListingPresenter: ContentListingPresenterInteractorInterface {
    
    func onFetchingGridContentSuccess(gridContent: GridContentController.GridContentResponse) {
        view.onFetchingGridContentSuccess(gridContent: gridContent.data)
    }
    
    func onFetchingRelatedContentSuccess(relatedContent: RelatedContentController.RelatedContentResponse) {
        view.onFetchingRelatedContentSuccess(relatedContent: relatedContent.data)
    }
    
    func onFetchingDataFailed(title: String, message: String) {
        view.onFetchingDataFailed(title: title, message: message)
    }
    
}

extension ContentListingPresenter: ContentListingPresenterViewInterface {
    
    func getGridContentBy(categoryKey: String, page: Int) {
        interactor.fetchGridContentBy(categoryKey: categoryKey, page: page)
    }
    
    func getRelatedContentBy(contentID: String) {
        interactor.fetchRelatedContentBy(contentID: contentID)
    }
    
    func pushToContentDetailView(content: Content, type: ContentType, shouldEmbedNavigation: Bool) {
        router.goToContentDetailView(content: content, type: type, shouldEmbedNavigation: shouldEmbedNavigation)
    }

}
