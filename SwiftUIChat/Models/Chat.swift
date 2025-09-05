//
//  Chat.swift
//  SwiftUIChat
//
//  Created by Ethan Lin on 2025/9/3.
//

import Foundation

struct Chat: Decodable, Identifiable {
    let id: String
    var messages: [Message]
    
    var recentMessageText: String {
        messages.last?.text ?? ""
    }
    
    var recentMessageDateString: String {
        guard let recentMessage = messages.last else { return "" }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = formatter.date(from: recentMessage.date) else { return "" }
        formatter.dateFormat = "MM/dd"
        
        return formatter.string(from: date)
    }
}
