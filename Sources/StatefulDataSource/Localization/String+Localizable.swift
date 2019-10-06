//
//  String+Localizable.swift
//  StatefulDataSource
//
//  Created by Eugene Peschard on 21/03/2019.
//  Copyright © 2019 pesch.app All rights reserved.
//

import Foundation

public extension String {

    /// Returns a localized string, using the main bundle
    public var localized: String {
        return NSLocalizedString(self, comment: self)
    }
}

public extension String {
    /// Namespace to access all localizable strings in the project
    public enum Localized {

        //MARK: - Generic
        public enum Generic {
            public enum Label {
                public static let empty = "GENERIC_LABEL_EMPTY".localized
            }
        }
    }
}

