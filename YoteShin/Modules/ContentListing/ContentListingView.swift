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
    var categorizedContent: CategorizedContent!
    var category: CategoryController.Categories! // use to fetch grid content
    var movieContent: MovieContentController.MovieContents! // use to fetch list content
    var content: Content! // use to fetch content detail
    static let identifier = "ContentListingView"
    private var loadingView = UIView()
    private var isLoadingMoreData: Bool = false
    private var shouldShowFooterView: Bool = false
    private var isLastPage: Bool = false
    private var currentPage: Int = 1
    
    var type: ContentListingType! {
        didSet {
            self.renderContent(for: self.type)
        }
    }
    
    private var gridContent: [Content] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private var relatedContent: [Content] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    // MARK: Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerReusableCollectionCell()
        registerReusableCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if (type == .contentDetail), let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        if (type == .contentDetail) {
            preferredContentSize.height = 210
            collectionView.layoutIfNeeded()
        }
        
        if (type == .grid) && shouldShowFooterView {
            collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    // MARK: Custom Methods
    
    private func registerReusableCollectionCell() {
        collectionView.register(UINib(nibName: MovieCell.identifier, bundle: nil), forCellWithReuseIdentifier: MovieCell.identifier)
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
                if (self.type == .grid) {
                    if self.currentPage == 1 {
                        self.loadingView = self.showLoadingView(at: self.view)
                    }
                    
                    self.presenter.getGridContentBy(categoryKey: self.category.key, page: self.currentPage)
                }
                
                if (self.type == .contentDetail) {
                    DispatchQueue.main.async {
                        self.loadingView = self.showLoadingView(at: self.view)
                    }
                    
                    self.presenter.getRelatedContentBy(contentID: self.content.movieID)
                }
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
    
    private func renderContent(for type: ContentListingType) {
        switch type {
        case .list:
            self.movieContent = categorizedContent.movieContent
            self.title = movieContent.title
            break
            
        case .grid:
            self.category = categorizedContent.category
            self.title = category.title
            loadingView = showLoadingView(at: self.view)
            presenter.getGridContentBy(categoryKey: category.key, page: currentPage)
            break
            
        case .contentDetail:
            self.content = categorizedContent.content
            
            DispatchQueue.main.async {
                self.loadingView = self.showLoadingView(at: self.view)
            }
            
            presenter.getRelatedContentBy(contentID: content.movieID)
        }
    }
    
    private func showNoRelatedContentLabel() {
        let textLabel = UILabel.init(frame: .zero)
        textLabel.text = "There is no related content"
        textLabel.textAlignment = .center
        textLabel.textColor = .gray
        textLabel.font = UIFont.systemFont(ofSize: 12)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        DispatchQueue.main.async {
            self.view.addSubview(textLabel)
            
            NSLayoutConstraint.activate([
                textLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                textLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
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
    
    func onFetchingRelatedContentSuccess(relatedContent: RelatedContentController.RelatedContents) {
        hideLoadingView(at: loadingView)
        self.relatedContent = relatedContent.content
        
        if (content.movieContentType == "clips") && relatedContent.content.isEmpty {
            showNoRelatedContentLabel()
        }
    }
    
    func onFetchingDataFailed(title: String, message: String) {
        hideLoadingView(at: loadingView)
        showAlert(title: title, message: message)
    }
    
}

// MARK: Collection View

extension ContentListingView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch type {
        case .list:
            return movieContent.content.count

        case .grid:
            return gridContent.count

        case .contentDetail:
            return relatedContent.count

        case .none:
            fatalError()
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        
        switch type {
        case .list:
            cell.data(content: movieContent.content[indexPath.row])
            return cell
            
        case .grid:
            cell.data(content: gridContent[indexPath.row])
            return cell
            
        case .contentDetail:
            cell.data(content: relatedContent[indexPath.row])
            return cell
            
        case .none:
            fatalError()
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(110), height: CGFloat(170))
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if (type == .grid) && (indexPath.row == gridContent.count - 1) && !isLoadingMoreData && !isLastPage {
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
        
        if (type == .grid) && shouldShowFooterView {
            shouldShowFooterView = false
            return CGSize(width: view.frame.size.width, height: 40)
        }
        
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var view = UIViewController()
        
        switch type {
        case .list:
            print("-- list content -> \(movieContent.content[indexPath.row])")
            let type = (movieContent.content[indexPath.row].movieURL == "") ? ContentType.episode : ContentType.movie
            view = ContentDetailModule().build(content: movieContent.content[indexPath.row], type: type)
            break
            
        case .grid:
            print("-- grid content -> \(gridContent[indexPath.row].movieURL)")
            let type = (gridContent[indexPath.row].movieURL == "") ? ContentType.episode : ContentType.movie
            view = ContentDetailModule().build(content: gridContent[indexPath.row], type: type)
            break
            
        case .contentDetail:
            print("-- content detail -> \(relatedContent[indexPath.row])")
            let type = (relatedContent[indexPath.row].movieURL == "") ? ContentType.episode : ContentType.movie
            view = ContentDetailModule().build(content: relatedContent[indexPath.row], type: type)
            break
            
        case .none:
            fatalError()
            break
        }
        
        navigationController?.pushViewController(view, animated: true)
    }
    
}
