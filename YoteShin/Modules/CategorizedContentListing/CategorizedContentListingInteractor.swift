//
//  CategorizedContentListingInteractor.swift
//  CategorizedContentListing
//
//  Created by Aung Chan Nyein on 12/11/21.
//

import Foundation

final class CategorizedContentListingInteractor: InteractorInterface {

    weak var presenter: CategorizedContentListingPresenterInteractorInterface!
}

extension CategorizedContentListingInteractor: CategorizedContentListingInteractorPresenterInterface {

    func fetchContentBy(categoryKey: String) {
        let payload = MovieContentPayload(categoryKey: categoryKey)
        let request = MovieContentController.MovieContentRequest(payload: payload)
        
        API.movie.get(request).onSuccess { result in
            guard self.presenter != nil else { return }
            self.presenter.onFetchingContentListSuccess(content: result)
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
