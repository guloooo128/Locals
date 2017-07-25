import Foundation
import Spectre
@testable import LocalsKit

public func specLocalsKit() {
    
    describe("Search Rule") {
        $0.it("regex") {
            
            let s1 = "\"TabBar.Lecture\"= \"Webinar\";\r\"TabBar.MenteePortal\"              = \"Mentee portal\""
          
            
            let seacher = SwiftSearcher()
            let result1 = seacher.search(in: s1)
          
            
            let expected: Set<String> = ["TabBar.Lecture", "TabBar.MenteePortal"]
            try expect(result1) == expected
        }
        
    }
    
}
