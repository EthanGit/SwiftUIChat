//
//  Message.swift
//  SwiftUIChat
//
//  Created by Ethan Lin on 2025/9/3.
//

import Foundation

struct Message {
    let id: String = UUID().uuidString
    let text: String
    let user: User
    let date: Date
    let readed: Bool
}
