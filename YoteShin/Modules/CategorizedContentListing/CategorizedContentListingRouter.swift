//
//  CategorizedContentListingRouter.swift
//  CategorizedContentListing
//
//  Created by Aung Chan Nyein on 12/11/21.
//

import Foundation
import UIKit

final class CategorizedContentListingRouter: RouterInterface {

    weak var presenter: CategorizedContentListingPresenterRouterInterface!

    weak var viewController: UIViewController?
}

extension CategorizedContentListingRouter: CategorizedContentListingRouterPresenterInterface {

    func goToContentListingView(contentList: MovieContentController.MovieContents) {
        let view = ContentListingModule().build(category: nil, movieContent: contentList, type: .list)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
}
