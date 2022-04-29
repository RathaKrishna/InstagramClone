//
//  StringExtensions.swift
//  SwiftInstagram
//
//  Created by Rathakrishnan Ramasamy on 27/04/22.
//

import Foundation

extension String {
    func safeDatabaseKey() -> String {
        
        return self.replacingOccurrences(of: ".", with: "-").self.replacingOccurrences(of: "@", with: "-")
    }
}
