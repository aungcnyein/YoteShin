//
//  EpisodeContentListingPresenter.swift
//  EpisodeContentListing
//
//  Created by Aung Chan Nyein on 12/16/21.
//

import Foundation

final class EpisodeContentListingPresenter: PresenterInterface {

    var router: EpisodeContentListingRouterPresenterInterface!
    var interactor: EpisodeContentListingInteractorPresenterInterface!
    weak var view: EpisodeContentListingViewPresenterInterface!

}

extension EpisodeContentListingPresenter: EpisodeContentListingPresenterRouterInterface {

}

extension EpisodeContentListingPresenter: EpisodeContentListingPresenterInteractorInterface {

    func onFetchingEpisodeContentSuccess(episodeContent: EpisodeContentController.EpisodeContentResponse) {
        view.onFetchingEpisodeContentSuccess(episodeContent: episodeContent.data)
    }
    
    func onFetchingDataFailed(title: String, message: String) {
        view.onFetchingDataFailed(title: title, message: message)
    }
    
}

extension EpisodeContentListingPresenter: EpisodeContentListingPresenterViewInterface {

    func getEpisodeContentBy(contentID: String, page: Int) {
        interactor.fetchEpisodeContentBy(contentID: contentID, page: page)
    }
    
}
