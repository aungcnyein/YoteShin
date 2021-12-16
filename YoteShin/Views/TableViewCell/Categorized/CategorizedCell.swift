//
//  CategorizedCell.swift
//  YoteShin
//
//  Created by Aung Chan Nyein on 12/9/21.
//

import UIKit

class CategorizedCell: UITableViewCell {

    // MARK: Properties
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var seeAllButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    static let identifier = "CategorizedCell"
    private var listener: CategorizedCellInterface!
    
    private var contentList: MovieContentController.MovieContents! {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: Init
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
        registerMovieCollectionViewCell()
    }
    
    @IBAction func didTapSeeAll(_ sender: Any) {
        listener.routeToContentListingView(contentList: contentList)
    }
    
    // MARK: Custom Methods
    
    func data(contentList: MovieContentController.MovieContents, listener: CategorizedCellInterface) {
        titleText.text = contentList.title
        self.contentList = contentList
        self.listener = listener
    }
    
    private func configureUI() {
        seeAllButton.setTitleColor(.label, for: .normal)
    }
    
    private func registerMovieCollectionViewCell() {
        collectionView.register(UINib(nibName: MovieCell.identifier, bundle: nil), forCellWithReuseIdentifier: MovieCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
}

// MARK: Collection View

extension CategorizedCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentList.content.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        cell.data(content: contentList.content[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        listener.routeToContentDetailView(content: contentList.content[indexPath.row])
    }
    
}
