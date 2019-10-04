//  ViewDataReusable.swift
//  StatefulDataSource
//
//  Created by Eugène Peschard on 04/10/2019.
//  Copyright © 2019 pesch.app All rights reserved.
//

#if !os(macOS)
import UIKit
#else
import Foundation
#endif


public protocol ViewDataReusable: ViewDataConfigurable {
    static var reuseType: ReuseType { get }
    static var reuseIdentifier: String { get }
}

//MARK:- Extensions

public extension ViewDataReusable {
    public static var reuseIdentifier: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!

    }
    public static var reuseType: ReuseType {
        return .classReference(self)
    }
}

public enum ReuseType {
    #if !os(macOS)
    case nib(UINib)
    #endif
    case classReference(AnyClass)
}

public protocol ViewDataConfigurable: class {
    associatedtype VM
    func configure(for vm: VM)
}
