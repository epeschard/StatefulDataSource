//
//  UITableView+Ext.swift
//  StatefulDataSource
//
//  Created by Eugène Peschard on 04/10/2019.
//  Copyright © 2019 pesch.app All rights reserved.
//

#if !os(macOS)
import UIKit

extension UITableView {

    func register<T: UITableViewCell>(reusable: T.Type) where T: ViewDataReusable {
        switch T.reuseType {
        case .classReference(let className):
            self.register(className, forCellReuseIdentifier: T.reuseIdentifier)
        case .nib(let nib):
            self.register(nib, forCellReuseIdentifier: T.reuseIdentifier)
        }
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: ViewDataReusable {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Did you register this cell?")
        }
        return cell
    }

    func showEmptyView(with message: String) {
        self.separatorStyle = .none
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont.systemFont(ofSize: 19.0, weight: .light)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel;
    }

    func removeEmptyView() {
        self.separatorStyle = .singleLine
        self.backgroundView = nil
    }
}
#endif
