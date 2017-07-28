//
//  Locals.swift
//  Locals
//
//  Created by Gollum on 2017/7/26.
//
//

import Foundation
import PathKit
import Rainbow


public struct LocalsItem {
    
    public var rootItems: [[String]]
    
    public var structName: String
    
    public var parrentNames: [String]
    
    
    private var itemNames: [String] {
        return rootItems.filter({$0.count == 1}).flatMap({$0.first!})
    }
    
    private var collectItems: [[String]] {
        return rootItems.filter({$0.count > 1})
    }
    
    private var filterItemNames: Set<String> {
        var names = Set<String>()
        for item in collectItems {
            names.update(with: item.first!)
        }
        return names
    }
    
    public var nameValues: [String: String] {
        var valuesDic = [String: String]()
        itemNames.forEach { (name) in
            let allNames = parrentNames + [name]
            let value = allNames.joined(separator: ".")
            valuesDic.updateValue(value, forKey: name)
        }
        return valuesDic
    }
    
    public var subItems: [String: [[String]]] {
        var subItemsDic = [String: [[String]]]()
        filterItemNames.forEach { (name) in
            var filterItems = collectItems.filter({$0.first == name})
            filterItems =  filterItems.map { (item) -> [String] in
                var newItem = item
                newItem.removeFirst()
                return newItem
            }
            subItemsDic.updateValue(filterItems, forKey: name)
        }
        return subItemsDic
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
    
    public func searchLocalizableNames(at path: Path) -> Set<String> {
        guard let subPathes = try? path.children() else {
            print("Failed to get contents in path: \(path)".red)
            return []
        }
        
        var result = Set<String>()
        
        for subPath in subPathes {
            if subPath.isDirectory && subPath.extension == "lproj" {
                result.formUnion(searchLocalizableNames(at: subPath))
                continue
            }
            
            guard subPath.extension == "strings" else {
                continue
            }
            
            let searcher = SwiftSearcher()
            
            let content = (try? subPath.read()) ?? ""
            
            result.formUnion(searcher.search(in: content))
        }
        return result
    }
    
    
    //生成格式化好的Swift文件
    public func createLocalizableFile(_ items: Set<String>) {
        let subItems = items.map({$0.components(separatedBy: ".")})
        
        var content = "import Foundation\n"
        content += createContentString(subItems)
        print(content.red.bold)
        
        do {
            try content.write(toFile: "\(Path.current.string)/Localizable.swift", atomically: true, encoding: String.Encoding.utf8)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func createContentString(_ items: [[String]])-> String {
        let localsItem = LocalsItem(rootItems: items,
                                    structName: "Localize",
                                    parrentNames: [])
        return createStructString(localsItem)
    }
    
    func createStructString(_ localsItem: LocalsItem) -> String {
        
        print("\(localsItem.parrentNames.count)".lightBlue)
        
        //单个Item直接生成字符串
        let structFormat = String(repeating: " ", count: localsItem.parrentNames.count * 4)
        let varFormat = String(repeating: " ", count: (localsItem.parrentNames.count + 1) * 4)
        
        var localizeString = "\n\(structFormat)struct \(localsItem.structName.replacingOccurrences(of: " ", with: "_")) {\n\n"
        
        localsItem.nameValues.forEach { (name, value) in
            
            
            localizeString += "\(varFormat)static let \(name.replacingOccurrences(of: " ", with: "_")) = NSLocalizedString(\"\(value)\", comment: \"\")\n\n"
        }
        
        localsItem.subItems.forEach { (name, items) in
            //拿到第一个相同的集合数组
            let lItems = LocalsItem(rootItems: items,
                                    structName: name,
                                    parrentNames: localsItem.parrentNames + [name])
            localizeString += createStructString(lItems)
        }
        localizeString += "\(structFormat)}\n"
        
        return localizeString
    }
    
}
