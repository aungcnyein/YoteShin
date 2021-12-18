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
    
    var episodeContent: EpisodeContent! {
        didSet {
            assignContentForEpisode()
        }
    }

    // MARK: Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        assignContentForMovie()
        registerNotificationCenter()
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
//        sender.alpha = 0.5
        
        switch sender.tag {
        case 0: // TODO: Go to play content
            if type == .movie {
                print("-- Play -> \(content.movieTitle), \(content.movieURL)")
            } else {
                print("-- Play -> \(episodeContent.episodeTitle), \(episodeContent.episodeURL)")
            }
            
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
    
    // MARK: Objc Methods
    
    @objc private func refreshEpisodeContent(notification: Notification) {
        if type == .episode {
            self.episodeContent = notification.object as? EpisodeContent
        }
    }
    
    @objc private func episodeContentReady(notification: Notification) {
        print("-- Episode content ready")
        self.episodeContent = notification.object as? EpisodeContent
    }
    
    // MARK: Custom Methods
    
    private func configureUI() {
        playButton.layer.cornerRadius = 10
        downloadButton.layer.cornerRadius = 10
        
        if type == .episode {
            DispatchQueue.main.async {
                self.titleText.text = "Loading..."
                self.imageView.image = UIImage(named: "img_placeholder")
                self.configureButton(shouldEnable: false)
            }
        }
    }
    
    private func configureButton(shouldEnable: Bool) {
        if type == .episode {
            playButton.isUserInteractionEnabled = shouldEnable
            downloadButton.isUserInteractionEnabled = shouldEnable
        }
    }
    
    private func registerNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(episodeContentReady(notification:)), name: Notification.Name(Notification.Noti.episodeContentReady), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshEpisodeContent(notification:)), name: Notification.Name(Notification.Noti.refreshEpisodeContent), object: nil)
    }
    
    private func assignContentForMovie() {
        titleText.text = content.movieTitle
        imageView.sd_setImage(with: URL(string: content.movieCover), placeholderImage: UIImage(named: "img_placeholder"))
    }
    
    private func assignContentForEpisode() {
        configureButton(shouldEnable: true)
        titleText.text = "\(content.movieTitle) - \(episodeContent.episodeTitle)"
        imageView.sd_setImage(with: URL(string: episodeContent.episodeCover), placeholderImage: UIImage(named: "img_placeholder"))
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
