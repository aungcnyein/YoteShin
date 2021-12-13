//
//  MainInteractor.swift
//  Main
//
//  Created by Aung Chan Nyein on 11/17/21.
//

import Foundation
import CodyFire

final class MainInteractor: InteractorInterface {

    weak var presenter: MainPresenterInteractorInterface!
}

extension MainInteractor: MainInteractorPresenterInterface {

    func fetchCategory() {
        let request = CategoryController.CategoryRequest(payload: CategoryPayload())
        
        API.category.get(request).onSuccess { result in
            guard self.presenter != nil else { return }
            self.presenter.onFetchingCategorySuccess(category: result)
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
