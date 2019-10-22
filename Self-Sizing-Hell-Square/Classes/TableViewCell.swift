//
//  TableViewCell.swift
//  Self-Sizing-Hell-Square
//
//  Created by Daniel Munoz on 22.10.19.
//  Copyright © 2019 Daniel Munoz. All rights reserved.
//

import Foundation
import UIKit

final class TableViewCell: UITableViewCell {
        
    static let reuseIdentifier = "TableViewCell"
    
    /// Value that determines the number of squares to display in the UICollectionView.
    private var numberOfSquares = 0 {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupCollectionView()
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    private func setupCollectionView() {
        self.collectionView.backgroundColor = .clear
        self.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
        self.collectionView.dataSource = self
    }
    
    private func setupUI() {
        self.contentView.addSubview(self.collectionView)
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
        
    }
    
    // MARK: - Data source update
    
    /// Updates the `numberOfSquares` property
    func update(numberOfSquares: Int) {
        self.numberOfSquares = numberOfSquares
        // The only way I found to force `self.collectionView.contentSize` to be (fairly)correct
        self.contentView.layoutIfNeeded()
    }
    
    // MARK: - Workaround
    
    // When this function is not overriden the "table view cell height zero" warning is displayed.
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        // Returns `collectionView.contentSize` in order to set the UITableVieweCell height a value greater than 0 and closer to the actual collection view value.
        return collectionView.contentSize
    }

}

// MARK: - UICollectionViewDataSource

extension TableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.numberOfSquares
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier, for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}
