//
//  Todo.swift
//  Top3
//
//  Created by Iulian Crisan on 06/05/2020.
//  Copyright © 2020 julianc. All rights reserved.
//

struct Todo {
    var title: String
    var isCompleted: Bool
    
    init(title: String, isCompleted: Bool) {
        self.title = title
        self.isCompleted = isCompleted
    }
    
    init?(data: [String: Any]) {

        guard let title = data["title"] as? String else { return nil }
        guard let isCompleted = data["isCompleted"] as? Bool else { return nil }
        
        self.title = title
        self.isCompleted = isCompleted
    }
}
