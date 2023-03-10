//
//  DataModel.swift
//  ToDoList
//
//  Created by Mike on 04.11.2022.
//

import Foundation
import UIKit

struct ToDos: Equatable, Codable {

    static let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let archiveURL = documentDirectory.appendingPathComponent("toDos").appendingPathExtension("plist")
    
    
    var id: UUID
    var title: String
    var isCompleated: Bool
    var dueDate: Date
    var notes: String?
    
    init(title: String, isCompleated: Bool, dueDate: Date, notes: String?) {
        self.id = UUID()
        self.title = title
        self.isCompleated = isCompleated
        self.dueDate = dueDate
        self.notes = notes
    }
    
    static func == (lhs: ToDos, rhs: ToDos) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func saveToDos(_ toDos: [ToDos]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedToDos = try? propertyListEncoder.encode(toDos)
        try? codedToDos?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadToDos() -> [ToDos]? {
        guard let codedToDos = try? Data(contentsOf: archiveURL)
        else { return nil }
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<ToDos>.self, from: codedToDos)
    }
    
    static func loadSampleToDos() -> [ToDos] {
        let toDo1 = ToDos(title: "Leanr Swift", isCompleated: false, dueDate: Date(), notes: "Notes 1")
        let toDo2 = ToDos(title: "Create app", isCompleated: false, dueDate: Date(), notes: "Notes 2")
        let toDo3 = ToDos(title: "Whatch TV", isCompleated: false, dueDate: Date(), notes: "Notes 3")
        
        return [toDo1, toDo2, toDo3]
    }
    
    
    
    
}
