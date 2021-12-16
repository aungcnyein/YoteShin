//
//  ContentListingInteractor.swift
//  ContentListing
//
//  Created by Aung Chan Nyein on 12/10/21.
//

import Foundation

final class ContentListingInteractor: InteractorInterface {

    weak var presenter: ContentListingPresenterInteractorInterface!
}

extension ContentListingInteractor: ContentListingInteractorPresenterInterface {

    func fetchGridContentBy(categoryKey: String, page: Int) {
        let payload = GridContentPayload(categoryKey: categoryKey, page: page)
        let request = GridContentController.GridContentRequest(payload: payload)
        
        API.gridContent.get(request).onSuccess { result in
            guard self.presenter != nil else { return }
            self.presenter.onFetchingGridContentSuccess(gridContent: result)
        }.onError { error in
            guard self.presenter != nil else { return }
            self.presenter.onFetchingDataFailed(title: "Please Try Again!", message: "\(error.description)")
        }.onTimeout {
            guard self.presenter != nil else { return }
            self.presenter.onFetchingDataFailed(title: "Please Try Again!", message: "Server is timeout.")
        }.onNetworkUnavailable {
            guard self.presenter != nil else { return }
            self.presenter.onFetchingDataFailed(title: "Please Try Again!", message: "There is no internet connection.")
        }
    }
    
    func fetchRelatedContentBy(contentID: String) {
        let payload = RelatedContentListPayload(videoId: contentID)
        let request = RelatedContentController.RelatedContentRequest(payload: payload)
        
        API.relatedContent.get(request).onSuccess { result in
            guard self.presenter != nil else { return }
            self.presenter.onFetchingRelatedContentSuccess(relatedContent: result)
        }.onError { error in
            guard self.presenter != nil else { return }
            self.presenter.onFetchingDataFailed(title: "Please Try Again!", message: "\(error.description)")
        }.onTimeout {
            guard self.presenter != nil else { return }
            self.presenter.onFetchingDataFailed(title: "Please Try Again!", message: "Server is timeout.")
        }.onNetworkUnavailable {
            guard self.presenter != nil else { return }
            self.presenter.onFetchingDataFailed(title: "Please Try Again!", message: "There is no internet connection.")
        }
    }
    
}
