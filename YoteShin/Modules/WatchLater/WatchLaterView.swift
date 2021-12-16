//
//  WatchLaterView.swift
//  WatchLater
//
//  Created by Aung Chan Nyein on 12/10/21.
//

import Foundation
import UIKit

final class WatchLaterView: UIViewController, ViewInterface {

    // MARK: Properties
    
    var presenter: WatchLaterPresenterViewInterface!
    static let identifier = "WatchLaterView"

    // MARK: Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: Custom Methods
    
    private func configureUI() {
        self.title = "Your Wishlist"
    }

}

extension WatchLaterView: WatchLaterViewPresenterInterface {

}
