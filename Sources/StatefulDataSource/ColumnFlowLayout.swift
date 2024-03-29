//
//  ColumnFlowLayout.swift
//  StatefulDataSource
//
//  Created by Eugène Peschard on 04/10/2019.
//  Copyright © 2019 pesch.app All rights reserved.
//

#if !os(macOS)
import UIKit

public class ColumnFlowLayout: UICollectionViewFlowLayout {

    public var cellHeight = CGFloat(65.0)

    public override func prepare() {
        super.prepare()

        guard let cv = collectionView else { return }

        let availableWidth = cv.bounds.inset(by: cv.layoutMargins).size.width

        let minColumnWidth = CGFloat(300.0)
        let maxColumnCount = Int(availableWidth / minColumnWidth)
        let cellWidth = (availableWidth / CGFloat(maxColumnCount)).rounded(.down)

        self.itemSize = CGSize(width: cellWidth, height: cellHeight)
        self.sectionInset = UIEdgeInsets(top: self.minimumInteritemSpacing, left: 0.0, bottom: 0.0, right: 0.0)
        if #available(iOS 11.0, *) {
            self.sectionInsetReference = .fromSafeArea
        } else {
            // Fallback on earlier versions
        }    }

}
#endif
