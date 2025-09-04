//
//  User.swift
//  SwiftUIChat
//
//  Created by Ethan Lin on 2025/9/3.
//

import Foundation

struct User: Decodable {
    let id: String
    let name: String
    let image: String
    
    var isCurrentUser: Bool {
        id == User.currentUser.id
    }
    
    static var currentUser: User {
        User(id: "1", name: "カーキ", image: "user01")
    }
}
