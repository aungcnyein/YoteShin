//
//  ContentDetailInteractor.swift
//  ContentDetail
//
//  Created by Aung Chan Nyein on 12/13/21.
//

import Foundation

final class ContentDetailInteractor: InteractorInterface {

    weak var presenter: ContentDetailPresenterInteractorInterface!
}

extension ContentDetailInteractor: ContentDetailInteractorPresenterInterface {

}
