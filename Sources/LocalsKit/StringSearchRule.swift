//
//  StringSearchRule.swift
//  Locals
//
//  Created by Gollum on 2017/7/25.
//
//

import Foundation

protocol StringsSearcher {
    func search(in content: String) -> Set<String>
}


protocol RegexStringsSearcher: StringsSearcher {
    var patterns: [String] { get }
}

extension RegexStringsSearcher {
    func search(in content: String) -> Set<String> {
        
        var result = Set<String>()
        for pattern in patterns {
            guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
                print("Failed to create regular expression: \(pattern)")
                continue
            }

            let matches = regex.matches(in: content, options: [], range: content.fullRange)
            
            for checkingResult in matches {
                let range = checkingResult.rangeAt(1)
                let extracted = NSString(string: content).substring(with: range)
                result.insert(extracted)
            }
        }
        return result
    }
}

struct SwiftSearcher: RegexStringsSearcher {
    let patterns: [String] = ["\"([^\t\n\r\";]*?)\"(?=\\s*\\=)"]
}

