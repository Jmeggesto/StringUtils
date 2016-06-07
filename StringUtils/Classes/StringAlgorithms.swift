//
//  StringAlgorithms.swift
//  Pods
//
//  Created by Jackie Meggesto on 5/23/16.
//
//

import Foundation

public extension String {
    
    /**
 
     Calculates the Levenshtein Distance between `self` and `string`. 
     See AlgorithmSource.swift for implementation, 
     or [Levenshtein Distance](https://en.wikipedia.org/wiki/Levenshtein_distance) on Wikipedia for more details.
     
    */
    public func distance(string: String) -> Int {
        
        return StringAlgorithms.LevenshteinDistance(self, string2: string)
        
    }
    
    
}