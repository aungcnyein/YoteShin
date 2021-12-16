//
//  ContentDescriptionPresenter.swift
//  ContentDescription
//
//  Created by Aung Chan Nyein on 12/16/21.
//

import Foundation

final class ContentDescriptionPresenter: PresenterInterface {

    var router: ContentDescriptionRouterPresenterInterface!
    var interactor: ContentDescriptionInteractorPresenterInterface!
    weak var view: ContentDescriptionViewPresenterInterface!

}

extension ContentDescriptionPresenter: ContentDescriptionPresenterRouterInterface {

}

extension ContentDescriptionPresenter: ContentDescriptionPresenterInteractorInterface {

}

extension ContentDescriptionPresenter: ContentDescriptionPresenterViewInterface {

}
