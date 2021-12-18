//
//  Notification.swift
//  YoteShin
//
//  Created by Aung Chan Nyein on 12/11/21.
//

import Foundation

extension Notification {
    
    enum Noti {
        static let didTapSegmentedControl: String = "didTapSegmentedControl"
        static let refreshEpisodeContent: String = "refreshEpisodeContent"
        static let episodeContentReady: String = "episodeContentReady"
    }
    
}
