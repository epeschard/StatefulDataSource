//
//  StatefulCollectionDataSource.swift
//  StatefulDataSource
//
//  Created by Eugène Peschard on 04/10/2019.
//  Copyright © 2019 pesch.app All rights reserved.
//

#if !os(macOS)
import UIKit

public class StatefulCollectionDataSource<Cell: ViewDataReusable & UICollectionViewCell>: NSObject, UICollectionViewDataSource {

    var activity: UIActivityIndicatorView

    public init(for collectionView: UICollectionView? = nil, _ state: ListState<Cell.VM>, activityIndicatorStyle: UIActivityIndicatorView.Style = .grey) {
        self.state = state
        self.collectionView = collectionView
        super.init()
        collectionView?.dataSource = self
        collectionView?.register(reusable: Cell.self)
        activity = UIActivityIndicatorView(style: activityIndicatorStyle)
    }

    var emptyView: UIView?
    public weak var collectionView: UICollectionView?
    public var state: ListState<Cell.VM> {
        didSet {
            collectionView?.reloadData()
        }
    }

    //MARK: - UICollectionViewDataSource

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        defer {
            addEmptyViewForCurrentState()
        }

        switch state {
        case .loaded(let data):
            return data.count
        default:
            return 0
        }
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: Cell = collectionView.dequeueReusableCell(for: indexPath)
        switch state {
        case .loaded(let data):
            let cellModel = data[indexPath.item]
            cell.configure(for: cellModel)
        default:
            break
        }
        return cell
    }

    func addEmptyViewForCurrentState() {
        self.emptyView?.removeFromSuperview()

        let newEmptyView: UIView? = {
            switch state {
            case .loaded(let data):
                if data.count == 0 {
                    let label = UILabel()
                    label.text = Localized.Generic.Label.empty
                    return label
                } else {
                    return nil
                }
                activity.stopAnimating()
            case .loading:
                let activity = UIActivityIndicatorView(style: .gray)
                activity.startAnimating()
                return activity
            case .failure(let error):
                let label = UILabel()
                label.text = "Error: \(error.localizedDescription)"
                activity.stopAnimating()
                return label
            }
        }()

        guard let emptyView = newEmptyView, let collectionView = self.collectionView else { return }

        emptyView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.addSubview(emptyView)
        if #available(iOS 9.0, *) {
            NSLayoutConstraint.activate([
                emptyView.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
                emptyView.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor, constant: -20)
            ])
        }
        self.emptyView = newEmptyView
    }
}
#else
//TODO: implement macOS variant
#endif
