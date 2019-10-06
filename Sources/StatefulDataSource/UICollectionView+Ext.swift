//
//  UICollectionView+Extension.swift
//  StatefulDataSource
//
//  Created by Eugène Peschard on 04/10/2019.
//  Copyright © 2019 pesch.app All rights reserved.
//

#if !os(macOS)
import UIKit

public extension UICollectionView {

    public func register<T: UICollectionViewCell>(reusable: T.Type) where T: ViewDataReusable {
        switch T.reuseType {
        case .classReference(let className):
            self.register(className, forCellWithReuseIdentifier: T.reuseIdentifier)
        case .nib(let nib):
            self.register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
        }
    }

    public func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ViewDataReusable {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Did you register this cell?")
        }
        return cell
    }

    public func showEmptyView(with message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        if #available(iOS 8.2, *) {
            messageLabel.font = UIFont.systemFont(ofSize: 19.0, weight: .light)
        }
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel;
    }

    public func removeEmptyView() {
        self.backgroundView = nil
    }
}
#endif
