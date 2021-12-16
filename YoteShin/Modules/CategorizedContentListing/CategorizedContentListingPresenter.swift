//
//  CategorizedContentListingPresenter.swift
//  CategorizedContentListing
//
//  Created by Aung Chan Nyein on 12/11/21.
//

import Foundation

final class CategorizedContentListingPresenter: PresenterInterface {

    var router: CategorizedContentListingRouterPresenterInterface!
    var interactor: CategorizedContentListingInteractorPresenterInterface!
    weak var view: CategorizedContentListingViewPresenterInterface!

}

extension CategorizedContentListingPresenter: CategorizedContentListingPresenterRouterInterface {

}

extension CategorizedContentListingPresenter: CategorizedContentListingPresenterInteractorInterface {
    
    func onFetchingContentListSuccess(content: MovieContentController.MovieContentResponse) {
        view.onContentListReady(content: content.data)
    }
    
    func onFetchingDataFailed(title: String, message: String) {
        view.onFetchingDataFailed(title: title, message: message)
    }

}

extension CategorizedContentListingPresenter: CategorizedContentListingPresenterViewInterface {
    
    func getContentBy(categoryKey: String) {
        interactor.fetchContentBy(categoryKey: categoryKey)
    }
    
    func pushToContentListingView(contentList: MovieContentController.MovieContents) {
        router.goToContentListingView(contentList: contentList)
    }
    
    func pushToContentDetailView(content: Content) {
        router.goToContentDetailView(content: content)
    }
    
}
