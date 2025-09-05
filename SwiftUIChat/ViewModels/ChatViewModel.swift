//
//  ChatViewModel.swift
//  SwiftUIChat
//
//  Created by Ethan Lin on 2025/9/4.
//

import Foundation

class ChatViewModel: ObservableObject {
    
    @Published var chatData: [Chat] = []
    
    init() {
        chatData = fetchChatData()
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
    
    func addMessage(chatId: String, text: String) {
        guard let index = chatData.firstIndex(where: { chat in
            chat.id == chatId
        }) else { return }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDateString = formatter.string(from: Date())
        
        let newMessage = Message(
            id: UUID().uuidString,
            text: text,
            user: User.currentUser,
            date: formattedDateString,
            readed: false
        )
        
        chatData[index].messages.append(newMessage)
    }
    
    func getTitle(messages: [Message]) -> String {
        var title = ""
        let names = getMembers(messages: messages, type: .name)
        
        for name in names {
            title += title.isEmpty ? name : ", \(name)"
        }
        
        return title
    }
    
    func getImages(messages: [Message]) -> [String] {
        getMembers(messages: messages, type: .image)
    }
    
    private func getMembers(messages: [Message], type: ValueType) -> [String] {
        var members: [String] = []
        var userIds: [String] = []
        
        for message in messages {
            let id = message.user.id
            if id == User.currentUser.id { continue }
            if userIds.contains(id) { continue }
            userIds.append(id)
            
            switch type {
            case .name:
                members.append(message.user.name)
            case .image:
                members.append(message.user.image)
            }
        }
        
        return members
    }
    
}

enum ValueType {
    case name
    case image
}
