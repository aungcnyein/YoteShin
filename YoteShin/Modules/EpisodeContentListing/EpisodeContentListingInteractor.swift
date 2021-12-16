//
//  EpisodeContentListingInteractor.swift
//  EpisodeContentListing
//
//  Created by Aung Chan Nyein on 12/16/21.
//

import Foundation

final class EpisodeContentListingInteractor: InteractorInterface {

    weak var presenter: EpisodeContentListingPresenterInteractorInterface!
}

extension EpisodeContentListingInteractor: EpisodeContentListingInteractorPresenterInterface {

    func fetchEpisodeContentBy(contentID: String, page: Int) {
        let payload = EpisodeContentListPayload(videoId: contentID, page: page)
        let request = EpisodeContentController.EpisodeContentRequest(payload: payload)
        
        API.episodeContent.get(request).onSuccess { result in
            guard self.presenter != nil else { return }
            self.presenter.onFetchingEpisodeContentSuccess(episodeContent: result)
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
