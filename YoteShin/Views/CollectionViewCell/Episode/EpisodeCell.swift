//
//  EpisodeCell.swift
//  YoteShin
//
//  Created by Aung Chan Nyein on 12/16/21.
//

import UIKit
import SDWebImage

class EpisodeCell: UICollectionViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var uvBackground: UIView!
    @IBOutlet weak var imagePosterView: UIImageView!
    @IBOutlet weak var episodeLabelView: UIView!
    @IBOutlet weak var episodeLabel: UILabel!
    
    static let identifier = "EpisodeCell"

    // MARK: Init
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: Custom Methods
    
    func data(episodeContent: EpisodeContent) {
        episodeLabel.text = episodeContent.episodeTitle
        imagePosterView.sd_setImage(with: URL(string: episodeContent.episodeCover), placeholderImage: UIImage(named: "img_placeholder"))
    }

}
