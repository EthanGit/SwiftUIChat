//
//  DataModelTest.swift
//  SwiftUIChat
//
//  Created by Ethan Lin on 2025/9/3.
//

import SwiftUI

struct DataModelTest: View {
    
    let user1 = User(id: "1", name: "Ethan", image: "user01")
    let user2 = User(id: "2", name: "Alice", image: "user02")
    
    let message = Message(
        text: "こんにちは！",
        user: User(id: "1", name: "Ethan", image: "user01"),
        date: Date(),
        readed: false
    )
    
    var body: some View {
        VStack {
            Text(user2.name)
            Image(user2.image)
            
            Text(message.text)
            Text(message.user.name)
        }
    }
}

#Preview {
    DataModelTest()
}
