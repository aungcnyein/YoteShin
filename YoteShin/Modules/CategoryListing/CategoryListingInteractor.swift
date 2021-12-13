//
//  CategoryListingInteractor.swift
//  CategoryListing
//
//  Created by Aung Chan Nyein on 12/11/21.
//

import Foundation

final class CategoryListingInteractor: InteractorInterface {

    weak var presenter: CategoryListingPresenterInteractorInterface!
}

extension CategoryListingInteractor: CategoryListingInteractorPresenterInterface {
    
}
