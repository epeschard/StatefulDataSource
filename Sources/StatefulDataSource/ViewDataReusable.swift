#if !os(macOS)
import UIKit
#else
import Foundation
#endif


protocol ViewDataReusable: ViewDataConfigurable {
    static var reuseType: ReuseType { get }
    static var reuseIdentifier: String { get }
}

//MARK:- Extensions

extension ViewDataReusable {
    public static var reuseIdentifier: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!

    }
    public static var reuseType: ReuseType {
        return .classReference(self)
    }
}

enum ReuseType {
    #if !os(macOS)
    case nib(UINib)
    #endif
    case classReference(AnyClass)
}

protocol ViewDataConfigurable: class {
    associatedtype VM
    func configure(for vm: VM)
}
