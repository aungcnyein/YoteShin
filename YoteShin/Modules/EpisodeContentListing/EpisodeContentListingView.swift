//
//  EpisodeContentListingView.swift
//  EpisodeContentListing
//
//  Created by Aung Chan Nyein on 12/16/21.
//

import Foundation
import UIKit

final class EpisodeContentListingView: UIViewController, ViewInterface {
    
    // MARK: Properties
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: EpisodeContentListingPresenterViewInterface!
    static let identifier = "EpisodeContentListingView"
    private var isLoadingMoreData: Bool = false
    private var isLastPage: Bool = false
    private var shouldShowFooterView: Bool = false
    private var loadingView = UIView()
    private var currentPage: Int = 1
    
    var content: Content! {
        didSet {
            presenter.getEpisodeContentBy(contentID: self.content.movieID, page: currentPage)
        }
    }
    
    private var episodeContent: [EpisodeContent] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    // MARK: Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        registerReusableCollectionCell()
        registerReusableCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        preferredContentSize.height = 210
        collectionView.layoutIfNeeded()
        
        if shouldShowFooterView {
            collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    // MARK: Custom Methods
    
    private func configureUI() {
        DispatchQueue.main.async {
            self.loadingView = self.showLoadingView(at: self.view)
        }
    }
    
    private func registerReusableCollectionCell() {
        collectionView.register(UINib(nibName: EpisodeCell.identifier, bundle: nil), forCellWithReuseIdentifier: EpisodeCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func registerReusableCollectionView() {
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
                    DispatchQueue.main.async {
                        self.loadingView = self.showLoadingView(at: self.view)
                    }
                }

                self.presenter.getEpisodeContentBy(contentID: self.content.movieID, page: self.currentPage)
            }
        ))
        
        present(alert, animated: true, completion: nil)
    }
    
    private func loadMoreData() {
        if isLoadingMoreData {
            currentPage += 1
            presenter.getEpisodeContentBy(contentID: content.movieID, page: currentPage)
        }
    }

}

extension EpisodeContentListingView: EpisodeContentListingViewPresenterInterface {

    func onFetchingEpisodeContentSuccess(episodeContent: [EpisodeContent]) {
        NotificationCenter.default.post(name: Notification.Name(Notification.Noti.episodeContentReady), object: episodeContent[0])
        
        hideLoadingView(at: loadingView)
        self.episodeContent.append(contentsOf: episodeContent)
        self.isLoadingMoreData = false
        
        if episodeContent.isEmpty {
            isLastPage = true
        }
    }
    
    func onFetchingDataFailed(title: String, message: String) {
        hideLoadingView(at: loadingView)
        showAlert(title: title, message: message)
    }
    
}

// MARK: Collection View

extension EpisodeContentListingView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episodeContent.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeCell.identifier, for: indexPath) as! EpisodeCell
        cell.data(episodeContent: episodeContent[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(230), height: CGFloat(170))
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if (indexPath.row == episodeContent.count - 1) && !isLoadingMoreData && !isLastPage {
            isLoadingMoreData = true
            shouldShowFooterView = true
            viewDidLayoutSubviews()
            loadMoreData()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionFooterReusableView.identifier, for: indexPath) as! CollectionFooterReusableView
        return footerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        if shouldShowFooterView {
            shouldShowFooterView = false
            return CGSize(width: CGFloat(100), height: CGFloat(40))
        }
        
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: Notification.Name(Notification.Noti.refreshEpisodeContent), object: episodeContent[indexPath.row])
    }
    
}
