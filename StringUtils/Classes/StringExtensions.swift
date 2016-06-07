//
//  StringExtensions.swift
//  SwiftUtilsTest
//
//  Created by Jackie Meggesto on 5/18/16.
//  Copyright © 2016 Jackie Meggesto. All rights reserved.
//

import Foundation


//Standard library conveniences and extensions.

public extension String {
    
    
    /**
     
     Convenience property for a `String`'s length
     
     */
    public var length: Int {
        
        return self.characters.count
        
    }
    /**
     
     An Array of the individual substrings composing `self`. Read-only.
     
     */
    public var chars: [String] {
        
        return Array(self.characters).map({String($0)})
        
    }
    
    /**
     
     A Set<String> of the unique characters in `self`.
     
     */
    public var charSet: Set<String> {
        
        return Set(self.characters.map{String($0)})
        
    }
    
    public var firstCharacter: String? {
        
        return self.chars.first
        
    }
    
    public var lastCharacter: String? {
        
        return self.chars.last
        
    }
    
    public var isEmpty: Bool {
        
        return self.chars.isEmpty
        
    }
    /**
     
     Returns the number of times `string` appears in self.
     
     */
    public func count(string: String) -> Int {
        
        return self.regex.numberOfMatchesInString(string)
    }
    
    /**
     
     Returns the most common character in `self`. 
     If `self.chars.count` == `self.charSet.count`, returns the first string in `self.charSet`.
     
     */
    public func mostCommonCharacter() -> String {
        
        var mostCommon = ""
        var count = 0
        for string in self.charSet {
            
            if self.count(string) > count {
                
                count = self.count(string)
                mostCommon = string
            }
            
        }
        return mostCommon
        
    }
    /// Returns the first index where `value` appears in `self` or `nil` if
    /// `value` is not found.
    ///
    /// - Complexity: O(n).
    func indexOf(element: String) -> Int? {
        
        return self.chars.indexOf(element)
        
    }
    
    mutating func insertString(string: String, atIndex: Int) {
        
        var _copy = self.chars
        _copy.insert(string, atIndex: atIndex)
        self = _copy.joinWithSeparator("")
        
    }
    /**
     
     Function to allow range removal with Int Ranges.
     
     */
    mutating func removeRange(range: Range<Int>) {
        
        var _copy = self.chars
        _copy.removeRange(range)
        self = _copy.joinWithSeparator("")
        
    }
    
    /**
     
     Convenience wrapper around `String.componentsSeparatedByString`.
     
     */
    public func split(separator: String) -> [String] {
        
        return self.componentsSeparatedByString(separator)
        
    }
    
    /**
     
     Convenience wrapper around `String.stringByReplacingOccurencesOfString()`.
     
     */
    
    public mutating func replace(string: String, with: String) {
        
        self = self.stringByReplacingOccurrencesOfString(string, withString: with)
    }
    /**
     
     Returns a copy of `self` where copy is the reversed form of `self`.
     
     */
    public func reversed() -> String {
        
        return String(self.characters.reverse())
        
    }
    /**
     
     Reverses `self`.
     
     */
    public mutating func reverse() {
        self = String(self.characters.reverse())
    }
    
}

//Emoji-related properties and functions.

public extension String {
    
    
    /**
     
     Boolean representing whether `self` contains any emoji characters. 
     The unichar value ranges for testing emoji should not be assumed to be exhaustive,
     and extension of this property is highly encouraged.
     
     */
    public var containsEmoji: Bool {
        
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F, // Emoticons
            0x1F300...0x1F5FF,
            0x1F900...0x1F9FF,
            0x1F600...0x1F64F, // Misc Symbols and Pictographs
            0x1F680...0x1F6FF, // Transport and Map
            0x2600...0x26FF,   // Misc symbols
            0x2700...0x27BF,   // Dingbats
            0xFE00...0xFE0F,  // Variation Selectors
            0xF8FF:
                return true
            default:
                continue
            }
        }
        return false
    }
    
    public mutating func removeEmoji() {
        
        self = self.chars.filter({!$0.containsEmoji}).joinWithSeparator("")
        
    }
    
    public func stringByRemovingEmoji() -> String {
        
        return self.chars.filter({!$0.containsEmoji}).joinWithSeparator("")
    }
    
    
}

//Extensions for converting Strings into different value types,
//checking if String satisfies certain conditions.

public extension String {
    
    
    /**
     
     Performs a regular expression operation on `self` to determine 
     whether or not the String can be considered a valid email.
     
     */
    public func isEmail() -> Bool {
        
        return self.regex.matchesPattern("^[[:alnum:]._%+-]+@[[:alnum:].-]+\\.[A-Z]+$")
        
    }
    
    /**
     
     Uses regular expressions to determine whether `self` can be considered a valid numeric form.
     
     Currently supported numeric formats:
     - Int literal
     - Double literal
     
     
     */
    func isNumber() -> Bool {
        
        if (self.regex.matchesPattern(Regex.integerMatchingPattern) ||
            self.regex.matchesPattern(Regex.floatMatchingPattern))
            && !self.regex.matchesPattern(Regex.nonNumericMatchingPattern) {
            return true
        }
        return false
    }
    /**
     
     Uses regular expressions to determine whether `self` 
     can be considered a valid numeric form, 
     and if so, returns the numeric value of `self`
     
     Currently supported numeric formats:
     - Int literal
     - Double literal
     
     - returns:
        An NSNumber value representing the numeric value contained within `self`.
        If `self` is not a valid numeric format, returns nil.
     
     
     */
    func numericValue() -> NSNumber? {
        
        if self.isNumber() {
            if self.regex.matchesPattern(Regex.integerMatchingPattern) {
                return NSNumber(integer: Int(self)!)
            }
            if self.regex.matchesPattern(Regex.floatMatchingPattern) {
                return NSNumber(double: Double(self)!)
            }
        }
        return nil
    }
    
    
}

//Subscripts and slicing

public extension String
{
    
    
    /**
 
    */
    
    public func substring(from: Int, _ to: Int) -> String {
        let a = startIndex.advancedBy(from)
        let b = startIndex.advancedBy(to)
        return self[a..<b]
    }
    
    /**
 
    Skips over the characters of `self` by `n` and returns a complete string
     formed by concatenating the substrings.
 
    */
    public func everyNth(n: Int) -> String {
        if n > 0 {
            return String(characters.enumerate().filter({ $0.0 % n == 0 }).map({ $0.1 }))
        } else {
            return String(characters.reverse().enumerate().filter({ $0.0 % n == 0 }).map({ $0.1 }))
        }
        
    }
    
    
    /**
 
     Returns the character at index n of `self`.
    
     - returns: 
        If `n` is positive, returns the character at index `n` of `self`. 
        If `n` is negative, returns the character `n` steps from the end of `self`.
     
    */
    
    public subscript(n: Int) -> String {
        
        if n >= 0 {
            let a = startIndex.advancedBy(n)
            return String(self[a])
        } else {
            let a = startIndex.advancedBy(self.length + n)
            return String(self[a])
        }
        
        
    }
    
    /**
 
     Allows for subscripting with Range<Int>. 
     
     - parameters: 
        - integerRange: A Range<Int> object representing the range of `self`
          to be returned.
     - returns: 
        Returns the section of `self` from the start of `integerRange`,
        to the end of `integerRange`.
     
    */
    
    public subscript(integerRange: Range<Int>) -> String {
        return self.substring(integerRange.startIndex, integerRange.endIndex)
    }
    
    public func slice(from from: Int = 0, to: Int? = nil, by: Int = 1) -> String {
        
        var _to = to
        var _from = from
        if to == nil {
            
            _to = self.length
        }
        if _to < 0 {
            
            _to = self.length + _to!
            
        }
        if from < 0 {
            _from = self.length + from
        }
        
        return self.substring(_from, _to!).everyNth(by)
        
    }
    
}
