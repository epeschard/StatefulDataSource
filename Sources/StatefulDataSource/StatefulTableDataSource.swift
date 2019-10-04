//
//  StatefulTableDataSource.swift
//  StatefulDataSource
//
//  Created by Eugène Peschard on 04/10/2019.
//  Copyright © 2019 pesch.app All rights reserved.
//

#if !os(macOS)
import UIKit

public class StatefulTableDataSource<Cell: ViewDataReusable & UITableViewCell>: NSObject, UITableViewDataSource {

    public init(for tableView: UITableView? = nil, _ state: ListState<Cell.VM>) {
        self.state = state
        self.tableView = tableView
        super.init()
        tableView?.dataSource = self
        tableView?.register(reusable: Cell.self)
    }

    var emptyView: UIView?
    public weak var tableView: UITableView?
    public var state: ListState<Cell.VM> {
        didSet {
            tableView?.reloadData()
        }
    }

    //MARK: - UITableViewDataSource

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: Cell = tableView.dequeueReusableCell(for: indexPath)
        switch state {
        case .loaded(let data):
            let cellModel = data[indexPath.item]
            cell.configure(for: cellModel)
        default:
            break
        }
        return cell
    }

    //MARK: - Private

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
            case .loading:
                let activity = UIActivityIndicatorView(style: .gray)
                activity.startAnimating()
                return activity
            case .failure(let error):
                let label = UILabel()
                label.text = "Error: \(error.localizedDescription)"
                return label
            }
        }()

        guard let emptyView = newEmptyView, let tableView = self.tableView else { return }

        tableView.addSubview(emptyView)
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        emptyView.centerYAnchor.constraint(equalTo: tableView.centerYAnchor, constant: -20).isActive = true
        self.emptyView = newEmptyView
    }
}
#else
//TODO: implement macOS variant
#endif
