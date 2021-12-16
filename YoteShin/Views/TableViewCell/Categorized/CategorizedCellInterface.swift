//
//  CategorizedCellInterface.swift
//  YoteShin
//
//  Created by Aung Chan Nyein on 12/10/21.
//

import Foundation

protocol CategorizedCellInterface {
    func routeToContentListingView(contentList: MovieContentController.MovieContents)
    func routeToContentDetailView(content: Content)
}
