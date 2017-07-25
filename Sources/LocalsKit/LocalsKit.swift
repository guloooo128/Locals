import Foundation
import PathKit

public struct Foo {
    
    public init() {
        
    }
    
    public func bar() {
        print("Hello world1111!")
    }
}

public struct Locals {
    
    let procjectPath: Path
    
    let excludedPaths: [Path]
    
    public init(procjectPath: String, excludedPaths: [String]) {
        let path = Path(procjectPath).absolute()
        self.procjectPath = path
        
        self.excludedPaths = excludedPaths.map { path + Path($0) }
    }
    
    //生成格式化好的Swift文件
    public func createLocalizableFile() {
        
    }

}
