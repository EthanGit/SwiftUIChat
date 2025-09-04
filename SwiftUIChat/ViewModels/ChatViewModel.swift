//
//  ChatViewModel.swift
//  SwiftUIChat
//
//  Created by Ethan Lin on 2025/9/4.
//

import Foundation

class ChatViewModel: ObservableObject {
    
    var chatData: [Chat] = []
    @Published var messages: [Message] = []
    
    init() {
        chatData = fetchChatData()
        messages = chatData.flatMap(\.messages)
    }
    
    private func fetchChatData() -> [Chat] {
        let fileName = "chatData.json"
        let data: Data
        
        guard let filePath = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            fatalError("\(fileName)が見つかりませんでした")
        }
        
        do {
            data = try Data(contentsOf: filePath)
        } catch {
            fatalError("\(fileName)の読み込みに失敗しました: \(error)")
        }
        
        do {
            return try JSONDecoder().decode(Array<Chat>.self, from: data)
        } catch {
            fatalError("\(fileName)の解析に失敗しました: \(error)")
        }
    }
    
    func addMessage(text: String) {
        let newMessage = Message(
            id: UUID().uuidString,
            text: text,
            user: User.currentUser,
            date: Date().description,
            readed: false
        )
        
        messages.append(newMessage)
    }
    
}
