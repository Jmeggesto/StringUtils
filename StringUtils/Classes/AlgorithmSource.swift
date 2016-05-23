//
//  AlgorithmSource.swift
//  Pods
//
//  Created by Jackie Meggesto on 5/23/16.
//
//

import Foundation

public struct StringAlgorithms {
    
    /**
     
     Levenshtein algorithm for measuring distance between strings. See article at: [Levenshtein Distance](https://en.wikipedia.org/wiki/Levenshtein_distance)
 
    */
    public static func LevenshteinDistance(string1: String, string2: String) -> Int {
        
        if string1 == string2 { return 0 }
        
        if string1.length == 0 { return string2.length }
        
        if string2.length == 0 { return string1.length }
        
        var v0 = Array<Int>(count: string2.length + 1, repeatedValue: 0)
        var v1 = Array<Int>(count: string2.length + 1, repeatedValue: 0)
        
        for i in 0..<v0.count {
            
            v0[i] = i
        }
        
        for i in 0..<string1.length {
            
            
            v1[0] = i + 1
            
            for j in 0..<string2.length {
                
                let cost = (string1[i] == string2[j]) ? 0 : 1 ;
                
                v1[j + 1] = min(v1[j] + 1, min(v0[j + 1] + 1, v0[j] + cost))
                
            }
            
            for j in 0..<v0.count {
                
                v0[j] = v1[j]
                
            }
            
        }
        
        return v1[string2.length]
        
    }
    
    
    
    
}