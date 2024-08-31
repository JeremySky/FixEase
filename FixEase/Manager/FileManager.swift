//
//  FileManager.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 8/28/24.
//

import Foundation

class FileManagerHelper {
    static let shared = FileManagerHelper()
    private init() {}
    
    private var fileManager = FileManager.default
    private let itemsDirectoryPath = "items"
    private lazy var itemsDirectory: URL = {
        let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return directory.appendingPathComponent(itemsDirectoryPath)
    }()
    
    func saveItem(_ item: Item) {
        let fileURL = itemsDirectory.appending(path: item.id.uuidString)
        
        do {
            let data = try JSONEncoder().encode(item)
            try data.write(to: fileURL)
            print("Item successfully saved to file.")
        } catch {
            print("Failed to save items: \(error)")
        }
    }
    
    func fetchItems() -> [Item]? {
        do {
            if !fileManager.fileExists(atPath: itemsDirectory.path) {
                try fileManager.createDirectory(at: itemsDirectory, withIntermediateDirectories: true)
            }
            
            let fileURLS = try fileManager.contentsOfDirectory(at: itemsDirectory, includingPropertiesForKeys: nil)
            return fileURLS.compactMap { fileURL in
                do {
                    let data = try Data(contentsOf: fileURL)
                    return try JSONDecoder().decode(Item.self, from: data)
                } catch {
                    print("Failed to decode Item from \(fileURL): \(error)")
                    return nil
                }
            }
        } catch {
            print("Failed to fetch URLs from directory: \(error)")
            return nil
        }
    }
}
