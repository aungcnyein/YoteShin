//
//  ContentDetailView.swift
//  ContentDetail
//
//  Created by Aung Chan Nyein on 12/13/21.
//

import Foundation
import UIKit

final class ContentDetailView: UIViewController, ViewInterface {
    
    // MARK: Properties
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var uvBackground: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerViewHeightConstraint: NSLayoutConstraint!
    
    var presenter: ContentDetailPresenterViewInterface!
    var content: Content!
    var type: ContentType!
    
    static let identifier = "ContentDetailView"

    // MARK: Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureSegmentedControl(type: self.type)
    }
    
    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        containerViewHeightConstraint.constant = container.preferredContentSize.height
    }
    
    @IBAction func didTapSegmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0 where type == .movie:
            presenter.embedContentListingView(at: containerView, with: content)
            break
            
        case 0 where type == .episode:
            presenter.embedEpisodeContentListingView(at: containerView, with: content)
            break
            
        case 1 where type == .movie:
            presenter.embedContentDescriptionView(at: containerView, with: content)
            break
            
        case 1 where type == .episode:
            presenter.embedContentListingView(at: containerView, with: content)
            break
            
        case 2 where type == .episode:
            presenter.embedContentDescriptionView(at: containerView, with: content)
            break
            
        default:
            fatalError()
            break
        }
    }
    
    @IBAction func didTapButton(_ sender: UIButton) {
        sender.alpha = 0.5
        
        switch sender.tag {
        case 0: // TODO: Go to play content
            
            break
            
        case 1: // TODO: Go to download content
            
            break
            
        default:
            fatalError("Can't determine")
            break
        }
    }
    
    @IBAction func didTouchDownButton(_ sender: UIButton) {
        sender.alpha = 0.5
    }
    
    @IBAction func didTouchDragOutsideButton(_ sender: UIButton) {
        sender.alpha = 1
    }
    
    @IBAction func didTouchDragInsideButton(_ sender: UIButton) {
        sender.alpha = 0.5
    }
    
    // MARK: Custom Methods
    
    private func configureUI() {
        playButton.layer.cornerRadius = 10
        downloadButton.layer.cornerRadius = 10
        
        titleText.text = content.movieTitle
        imageView.sd_setImage(with: URL(string: content.movieCover), placeholderImage: UIImage(named: "img_placeholder"))
    }
    
    private func configureSegmentedControl(type: ContentType) {
        switch type {
        case .movie:
            segmentedControl.removeSegment(at: 0, animated: true)
            segmentedControl.selectedSegmentIndex = 0
            presenter.embedContentListingView(at: containerView, with: content)
            break
            
        case .episode:
            presenter.embedEpisodeContentListingView(at: containerView, with: content)
            break
        }
    }

}

extension ContentDetailView: ContentDetailViewPresenterInterface {

}
