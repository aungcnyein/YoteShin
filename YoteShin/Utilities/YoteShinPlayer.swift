//
//  YoteShinPlayer.swift
//  YoteShin
//
//  Created by Aung Chan Nyein on 12/18/21.
//

import Foundation
import AVKit
import UIKit

class LandscapeAVPlayerController: AVPlayerViewController {

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
}

class YoteShinPlayer {
    
    class func play(for url: String, at viewController: UIViewController) {
        guard let url = URL(string: url) else { return }
        
        print("Play")
        
        let player = AVPlayer(url: url)
        let controller = AVPlayerViewController()
        controller.player = player

        viewController.present(controller, animated: true) {
            player.play()
        }
    }
    
    class func startPlay(for url: String, at viewController: UIViewController) {
        guard let url = URL(string: url) else { return }
        
        // Create player with url
        let player = AVPlayer(url: url)

        // Configure player
        /*
        let asset = AVAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: playerItem)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspect
         */

        // Create player view controller
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player

        // Configure player view controller
        let width = viewController.view.frame.size.width
        let playerFrame = CGRect(x: 0, y: 100, width: width, height: (width * 9) / 16)
        playerViewController.view.frame = playerFrame

        // Add player view controller as child to parent view controller
        viewController.addChild(playerViewController)

        // Add player view controller's view to parent's view
        viewController.view.addSubview(playerViewController.view)

        // Move player view controller to parent view controller
        playerViewController.didMove(toParent: viewController)

        player.play()
    }
    
}
