//
//  ContentDescriptionInteractor.swift
//  ContentDescription
//
//  Created by Aung Chan Nyein on 12/16/21.
//

import Foundation

final class ContentDescriptionInteractor: InteractorInterface {

    weak var presenter: ContentDescriptionPresenterInteractorInterface!
}

extension ContentDescriptionInteractor: ContentDescriptionInteractorPresenterInterface {

}
