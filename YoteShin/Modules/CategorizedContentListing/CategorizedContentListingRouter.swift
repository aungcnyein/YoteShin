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
        let categorizedContent = CategorizedContent(movieContent: contentList)
        let view = ContentListingModule().build(categorizedContent: categorizedContent, type: .list)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    func goToContentDetailView(content: Content) {
        let type = (content.movieURL == "") ? ContentType.episode : ContentType.movie
        let view = ContentDetailModule().build(content: content, type: type)
        viewController?.present(UINavigationController(rootViewController: view), animated: true, completion: nil)
    }
    
}
