//
//  ContentDescriptionRouter.swift
//  ContentDescription
//
//  Created by Aung Chan Nyein on 12/16/21.
//

import Foundation
import UIKit

final class ContentDescriptionRouter: RouterInterface {

    weak var presenter: ContentDescriptionPresenterRouterInterface!

    weak var viewController: UIViewController?
}

extension ContentDescriptionRouter: ContentDescriptionRouterPresenterInterface {

}