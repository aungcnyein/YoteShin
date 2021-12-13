//
//  MovieCell.swift
//  YoteShin
//
//  Created by Aung Chan Nyein on 12/9/21.
//

import UIKit
import SDWebImage

class MovieCell: UICollectionViewCell {

    // MARK: Properties
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var posterImage: UIImageView!
    
    static let identifier = "MovieCell"
    
    // MARK: Init
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: Custom Methods

    func data(content: Content) {
        posterImage.sd_setImage(with: URL(string: content.moviePoster), placeholderImage: UIImage(named: "img_placeholder"))
    }
    
}
