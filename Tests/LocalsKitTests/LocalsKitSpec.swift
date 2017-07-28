import Foundation
import Spectre
import PathKit
import Rainbow
@testable import LocalsKit

public func specLocalsKit() {
    
    describe("Search Rule") {
        $0.it("regex") {
            
            guard let pathes = try? Path.current.children() else {
                return
            }
            
            for path in pathes {
                print(path.string.red)
            }
            
            let s1 = "\"TabBar1.Lecture\"= \"Webinar\"    ;     \r\"TabBar.MenteePortal\"              = \"Mentee portal\";sdfsdfsdfsdfsdf\"TabBar.Lecture2\"= \"Webinar\";\"TabBar.MenteePortal\"              = \"Mentee portal\";   \"TabBar.Lecture3\"= \"Webinar\";\"TabBar.MenteePortal\"              = \"Mentee portal\";\"TabBar.Lecture4\"= \"Webinar\";\"TabBar.MenteePortal\"              = \"Mentee portal\";sdfsdfs\r\"TabBar.Lecture5\"= \"Webinar\";\"TabBar.MenteePortal\"              = \"Mentee portal\";\"TabBar.Lecture6\"= \"Webinar\";\"TabBar.MenteePortal\"              = \"Mentee portal\";\"TabBar.Lecture7\"= \"Webinar\";\"TabBar.MenteePortal\"              = \"Mentee portal\";\"TabBar.Lecture8\"= \"Webinar\";\"TabBar.MenteePortal\"              = \"Mentee portal\";\"TabBar11.Lecture\"= \"Webinar\";\"TabBar.MenteePortal\"              = \"Mentee portal\";\"TabBar.Lecture22\"= \"Webinar\";sdfsdfsdfs\"TabBar.MenteePortal\"                                 = \"Mentee portal\";"
            
            let seacher = SwiftSearcher()
            let result1 = seacher.search(in: s1)
            
            let expected: Set<String> = ["TabBar.MenteePortal", "TabBar.Lecture8", "TabBar.Lecture6", "TabBar.Lecture4", "TabBar.Lecture7", "TabBar11.Lecture", "TabBar1.Lecture", "TabBar.Lecture2", "TabBar.Lecture22", "TabBar.Lecture3", "TabBar.Lecture5"]
            try expect(result1) == expected
            
            let locals = Locals(procjectPath: Path.current.string, excludedPaths: [])
            let result2 = locals.searchLocalizableNames(at: Path.current)
            
            locals.createLocalizableFile(result2)
        }
        
    }
    
}
