//
//  ContentListingView.swift
//  ContentListing
//
//  Created by Aung Chan Nyein on 12/10/21.
//

import Foundation
import UIKit

final class ContentListingView: UIViewController, ViewInterface {

    // MARK: Properties
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: ContentListingPresenterViewInterface!
    var type: ContentListingType!
    var movieContent: MovieContentController.MovieContents!
    private var loadingView = UIView()
    private var isLoadingMoreData: Bool = false
    private var shouldShowFooterView: Bool = false
    private var isLastPage: Bool = false
    private var currentPage: Int = 1
    
    var category: CategoryController.Categories! {
        didSet {
            loadingView = showLoadingView(at: self.view)
            presenter.getGridContentBy(categoryKey: category.key, page: currentPage)
        }
    }
    
    private var gridContent: [Content] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    // MARK: Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        registerCollectionReusableCell()
        registerCollectionReusableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if (type == .grid) && shouldShowFooterView {
            collectionView.collectionViewLayout.invalidateLayout()
        }
        
    }
    
    // MARK: Custom Methods
    
    private func configureUI() {
        self.title = (type == .list) ? movieContent.title : category.title
    }
    
    private func registerCollectionReusableCell() {
        collectionView.register(UINib(nibName: MovieCell.identifier, bundle: nil), forCellWithReuseIdentifier: MovieCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func registerCollectionReusableView() {
        collectionView.register(CollectionFooterReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CollectionFooterReusableView.identifier)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: nil
        ))
        
        alert.addAction(UIAlertAction(
            title: "Try Again",
            style: .default,
            handler: { _ in
                if self.currentPage == 1 {
                    self.loadingView = self.showLoadingView(at: self.view)
                }
                self.presenter.getGridContentBy(categoryKey: self.category.key, page: self.currentPage)
            }
        ))
        
        present(alert, animated: true, completion: nil)
    }
    
    private func loadMoreData() {
        if isLoadingMoreData {
            currentPage += 1
            presenter.getGridContentBy(categoryKey: category.key, page: currentPage)
        }
    }

}

extension ContentListingView: ContentListingViewPresenterInterface {
    
    func onFetchingGridContentSuccess(gridContent: [Content]) {
        hideLoadingView(at: loadingView)
        self.gridContent.append(contentsOf: gridContent)
        self.isLoadingMoreData = false
        
        if gridContent.isEmpty {
            isLastPage = true
        }
    }
    
    func onFetchingGridContentFailed(title: String, message: String) {
        hideLoadingView(at: loadingView)
        showAlert(title: title, message: message)
    }
    
}

// MARK: Collection View

extension ContentListingView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (type == .list) ? movieContent.content.count : gridContent.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        
        (type == .list) ? cell.data(content: movieContent.content[indexPath.row]) : cell.data(content: gridContent[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionFooterReusableView.identifier, for: indexPath) as! CollectionFooterReusableView
        return footerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        if (type == .grid) && shouldShowFooterView {
            shouldShowFooterView = false
            return CGSize(width: view.frame.size.width, height: 40)
        }
        
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if (type == .grid) && (indexPath.row == gridContent.count - 1) && !isLoadingMoreData && !isLastPage {
            isLoadingMoreData = true
            shouldShowFooterView = true
            viewDidLayoutSubviews()
            loadMoreData()
        }
        
    }
    
}
