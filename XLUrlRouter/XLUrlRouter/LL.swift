//
//  LL.swift
//  LLUrlRouter
//
//  Created by wangxu on 2020/3/12.
//  Copyright © 2020 wangxu. All rights reserved.
//
import UIKit

public struct LL<Base> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

// MARK: - protocol for normal types
public protocol LLCompatible {}
public extension LLCompatible {
    static var ll: LL<Self>.Type {
        get { LL<Self>.self }
        set {}
    }
    var ll: LL<Self> {
        get { LL(self) }
        set {}
    }
}

// MARK: - protocol for types with a generic parameter
public struct LLGeneric<Base, LLT> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}
public protocol LLGenericCompatible {
    associatedtype LLT
}
public extension LLGenericCompatible {
    static var ll: LLGeneric<Self, LLT>.Type {
        get { LLGeneric<Self, LLT>.self }
        set {}
    }
    var ll: LLGeneric<Self, LLT> {
        get { LLGeneric(self) }
        set {}
    }
}

// MARK: - protocol for types with two generic parameter2
public struct LLGeneric2<Base, LLT1, LLT2> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}
public protocol LLGenericCompatible2 {
    associatedtype LLT1
    associatedtype LLT2
}
public extension LLGenericCompatible2 {
    static var ll: LLGeneric2<Self, LLT1, LLT2>.Type {
        get { LLGeneric2<Self, LLT1, LLT2>.self }
        set {}
    }
    var ll: LLGeneric2<Self, LLT1, LLT2> {
        get { LLGeneric2(self) }
        set {}
    }
}



// Mark: - 给UIViewController加前缀
extension UIViewController: LLCompatible { }
