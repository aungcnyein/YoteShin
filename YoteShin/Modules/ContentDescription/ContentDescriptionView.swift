//
//  ContentDescriptionView.swift
//  ContentDescription
//
//  Created by Aung Chan Nyein on 12/16/21.
//

import Foundation
import UIKit

final class ContentDescriptionView: UIViewController, ViewInterface {

    // MARK: Properties
    
    @IBOutlet weak var tableView: UITableView!

    typealias contentDescription = ContentDescription
    typealias contentDescriptionSection = ContentDescription.ContentDescriptionSection
    
    var presenter: ContentDescriptionPresenterViewInterface!
    static let identifier = "ContentDescriptionView"
    private let tvReuseIdentifier = "ContentDescriptionViewCell"
    
    var content: Content! {
        didSet {
            contentDescription.content = self.content
        }
    }
    
    // MARK: Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableReusableView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        preferredContentSize.height = tableView.contentSize.height
    }
    
    // MARK: Custom Methods
    
    private func registerTableReusableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: tvReuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension ContentDescriptionView: ContentDescriptionViewPresenterInterface {

}

// MARK: Table View

extension ContentDescriptionView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentDescriptionSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tvReuseIdentifier, for: indexPath)
        let contentDescriptionSection = contentDescriptionSection(rawValue: indexPath.row)
        
        var configuration = UIListContentConfiguration.valueCell()
        configuration.text = contentDescriptionSection?.description
        configuration.secondaryText = contentDescriptionSection?.detail
        
        cell.contentConfiguration = configuration
        
        return cell
    }
    
}
