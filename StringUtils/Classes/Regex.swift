//
//  Regex.swift
//  SwiftUtilsTest
//
//  Created by Jackie Meggesto on 5/18/16.
//  Copyright © 2016 Jackie Meggesto. All rights reserved.
//

import Foundation


/**
 
 The **Grep** struct provides an object wrapper for interacting with the **Regex** struct's **grep** function.
 
 - **originalString**: The original String upon which the regex operation was performed.
 
 
 
 - **matches**: An Array containing all the matches found in the original string
 
 
 */

public struct Grep: CustomStringConvertible {
    
    var originalString: String
    var matches = [String]()
    init(originalString: String) {
        self.originalString = originalString
    }
    
    public var description: String {
        return "[Grep] Original string: \"\(originalString)\", matches: \(matches)\n"
    }
    
}
/**
 
 The **R** struct (typealias: **Regex**) is a structure for performing regular expression operations on Strings.
 
 
 - **body** :
 The string upon which regular expression operations are to be performed.
 
 Instantiating this structure directly is discouraged: Strings possess a **regex** property by default via which regular expression operations should be performed.
 
 */
public typealias Regex = R
public struct R {
    
    public static let integerMatchingPattern = "^[1-9][0-9]*$"
    public static let floatMatchingPattern = "^[-+]?([0-9]*\\.[0-9]+|[0-9]+)$"
    public static let nonNumericMatchingPattern = "[a-zA-Z]"
    
    var body: String
    
    init(body: String) {
        self.body = body
    }
    
    /**
     
     Returns the number of times `pattern` appears in `self.body`.
     
     - parameters:
     - pattern: The regex pattern to find matches for.
     
     */
    public func numberOfMatchesInString(pattern: String) ->Int {
        
        var _pattern = "\(pattern)"
        _pattern = _pattern.replace("?", with: "\\?")
        let regex = try! NSRegularExpression(pattern: _pattern,
                                             options: [.CaseInsensitive])
        
        return regex.matchesInString(body, options: [], range: NSMakeRange(0, body.length)).count
        
    }
    /**
     
     Returns the first substring in `self.body` that matches `pattern`.
     
     - parameters:
     - pattern : The regex pattern to find matches for.
     
     */
    public func firstMatchInString(pattern: String, options: NSRegularExpressionOptions = [.CaseInsensitive], matchingOptions: NSMatchingOptions = []) -> String? {
        
        var _pattern = "\(pattern)"
        _pattern.replace("?", with: "\\?")
        let regex = try! NSRegularExpression(pattern: _pattern,
                                             options: options)
        let NSCopy = body as NSString
        let match = regex.firstMatchInString(body, options: matchingOptions, range: NSMakeRange(0, body.length))
        return match.map{NSCopy.substringWithRange($0.range)}
    }
    /**
     
     Returns an array of all substrings in `self.body` that match `pattern`.
     
     - parameters:
     - pattern : The regex pattern to find matches for.
     
     */
    public func matchesInString(pattern: String, options: NSRegularExpressionOptions = [.CaseInsensitive], matchingOptions: NSMatchingOptions = []) -> [String] {
        
        var _pattern = "\(pattern)"
        _pattern.replace("?", with: "\\?")
        let regex = try! NSRegularExpression(pattern: _pattern,
                                             options: options)
        let NSCopy = body as NSString
        let matches = regex.matchesInString(body, options: matchingOptions, range: NSMakeRange(0, body.length))
        return matches.map{NSCopy.substringWithRange($0.range)}
        
        
    }
    /**
     
     Tests whether or not `self.body` matches the given pattern.
     
     - parameters:
     - pattern : The regex pattern to find matches for.
     
     */
    
    public func matchesPattern(pattern: String, options: NSRegularExpressionOptions = [.CaseInsensitive], matchingOptions: NSMatchingOptions = []) -> Bool {
        
        var _pattern = "\(pattern)"
        _pattern.replace("?", with: "\\?")
        let regex = try! NSRegularExpression(pattern: _pattern,
                                             options: options)
        return regex.firstMatchInString(body, options: matchingOptions, range: NSMakeRange(0, body.length)) != nil
    }
    
    
    /**
     
     Checks an array of Strings to find matches to the given pattern.
     
     
     - parameters:
     - array : An Array of Strings to search for.
     - pattern: The regex pattern to find matches for.
     
     - returns:
     An Array of **Grep** objects where `Grep.originalString` is the string in which a match was found, and `Grep.matches` is an Array of all matches in `originalString`.
     
     */
    public static func grep(array: [String], pattern: String, options: NSRegularExpressionOptions = [.CaseInsensitive], matchingOptions: NSMatchingOptions = []) -> [Grep] {
        
        
        var tempgrep = [Grep]()
        for element in array {
            
            if element.regex.matchesPattern(pattern, options: options, matchingOptions: matchingOptions) {
                var newgrep = Grep(originalString: element)
                newgrep.matches = element.regex.matchesInString(pattern, options: options, matchingOptions: matchingOptions)
                tempgrep.append(newgrep)
            }
            
        }
        return tempgrep
    }
    /**
     
     Checks a Dictionary where Value is String to find matches to the given pattern.
     
     
     - parameters:
     - dict : A Dictionary of String value types to search for.
     - pattern: The regex pattern to find matches for.
     
     - returns:
     An Array of **Grep** objects where `Grep.originalString` is the string in which a match was found, and `Grep.matches` is an Array of all matches in `originalString`.
     
     */
    
    public static func grep<T where T: Hashable>(dict: Dictionary<T, String>, pattern: String, options: NSRegularExpressionOptions = [.CaseInsensitive], matchingOptions: NSMatchingOptions = []) -> [Grep] {
        
        var tempgrep = [Grep]()
        for (_, val) in dict {
            
            if val.regex.matchesPattern(pattern) {
                var newgrep = Grep(originalString: val)
                newgrep.matches = val.regex.matchesInString(pattern, options: options, matchingOptions: matchingOptions)
                tempgrep.append(newgrep)
            }
            
            
        }
        
        return tempgrep
    }
    
}

public extension String {
    
    public var regex: Regex {
        return Regex(body: self)
    }
    
}

infix operator =~ { associativity left precedence 140 }

/**
 A convenience function to test whether `lhs` matches the regular expression pattern of `rhs`. Equivalent to `lhs.regex.matchesPattern(rhs)`.
 
 */

public func =~(lhs: String, rhs: String) -> Bool {
    
    return lhs.regex.matchesPattern(rhs)
    
}
