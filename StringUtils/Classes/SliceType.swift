//
//  SliceType.swift
//  SwiftUtilsTest
//
//  Created by Jackie Meggesto on 5/18/16.
//  Copyright © 2016 Jackie Meggesto. All rights reserved.
//

import Foundation

/**
 
 A wrapper structure for representing the bounds of a Swift String slice.
 
 - start: The startIndex of the slice.
 
 - stop: The endIndex of the slice.
 
 - step: The interval at which to slice.
 
 */
public struct SliceType {
    
    var start = 0
    var stop: Int?
    var step = 1
}


//The following operators are designed to interact with Swift String subscripting to produce an API design reminiscent of Python's slice syntax. Given that Swift does not allow for the use of `:` in custom operators, full stops and `<` are used instead.

infix operator .. {associativity left precedence 110 }

public func ..(lhs: Int, rhs: Int) -> Range<Int> {
    
    return lhs..<rhs
    
}
public func ..(lhs: Range<Int>, rhs: Int) -> SliceType {
    
    return SliceType(start: lhs.startIndex, stop: lhs.endIndex, step: rhs)
    
}

infix operator ...<{associativity left precedence 140}
prefix operator ...<{}

public func ...<(lhs: Int, rhs: Int) -> SliceType {
    
    return SliceType(start: lhs, stop: nil, step: rhs)
    
}
public prefix func ...<(rhs: Int) -> SliceType {
    return SliceType(start: 0, stop: nil, step: rhs)
}


postfix operator ...{}

public postfix func ...(rhs: Int) -> SliceType {
    
    return SliceType(start: rhs, stop: nil, step: 1)
    
}


prefix operator ...<-{}

public prefix func ...<-(rhs: Int) -> SliceType {
    return SliceType(start: 0, stop: nil, step: rhs * -1)
}