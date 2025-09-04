//
//  Message.swift
//  SwiftUIChat
//
//  Created by Ethan Lin on 2025/9/3.
//

import Foundation

struct Message: Decodable, Identifiable {
    let id: String
    let text: String
    let user: User
    let date: String
    let readed: Bool
}
