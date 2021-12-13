//
//  CollectionFooterReusableView.swift
//  YoteShin
//
//  Created by Aung Chan Nyein on 12/12/21.
//

import UIKit

class CollectionFooterReusableView: UICollectionReusableView {
    
    // MARK: Properties
    
    static let identifier = "CollectionFooterLoadingView"
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.style = .medium
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(activityIndicatorView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        activityIndicatorView.frame = bounds
    }
    
}
