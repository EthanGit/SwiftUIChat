//
//  ChatView.swift
//  SwiftUIChat
//
//  Created by Ethan Lin on 2025/9/3.
//

import SwiftUI

struct ChatView: View {
    
    @State private var textFieldText: String = ""
    @FocusState private var textFieldFocused: Bool
    
    @StateObject var vm = ChatViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            // Message Area
            messageArea
            
            // Navigation Area
            .overlay (navigationArea, alignment: .top)
            
            // Input Area
            inputArea
        }
    }
}

#Preview {
    ChatView()
}

extension ChatView {
    
    private var messageArea: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(vm.messages) { message in
                        MessageRow(message: message)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 72)
            }
            .background(Color("Background"))
            .onTapGesture {
                textFieldFocused = false
            }
            .onAppear {
                Task {
                    await Task.delayed(by: 1.0)
                    scrollToLast(proxy: proxy)
                }
            }
        }
    }
    
    private var inputArea: some View {
        HStack {
            HStack() {
                Image(systemName: "plus")
                Image(systemName: "camera")
                Image(systemName: "photo")
            }
            .font(.title2)
            TextField("Aa", text: $textFieldText)
                .padding()
                .background(Color(uiColor: .secondarySystemBackground))
                .clipShape(Capsule())
                .overlay(
                    Image(systemName: "face.smiling")
                        .font(.title2)
                        .padding(.trailing)
                        .foregroundStyle(.gray)
                    , alignment: .trailing
                )
                .onSubmit {
                    sendMessage()
                }
                .focused($textFieldFocused)
            Image(systemName: "mic")
                .font(.title2)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color(uiColor: .systemBackground))
    }
    
    private var navigationArea: some View {
        HStack {
            Image(systemName: "chevron.backward")
                .font(.title2)
            Text("Title")
                .font(.title2.bold())
            Spacer()
            HStack(spacing: 16) {
                Image(systemName: "text.magnifyingglass")
                Image(systemName: "phone")
                Image(systemName: "line.3.horizontal")
            }
            .font(.title2)
        }
        .padding()
        .background(Color("Background").opacity(0.9))
    }
    
    private func sendMessage() {
        if textFieldText.isEmpty { return }
        vm.addMessage(text: textFieldText)
        textFieldText = ""
    }
    
    private func scrollToLast(proxy: ScrollViewProxy) {
        if let lastMessage = vm.messages.last {
            proxy.scrollTo(lastMessage.id, anchor: .bottom)
        }
    }
}

extension Task where Success == Never, Failure == Never {
    static func delayed(by timeInterval: TimeInterval) async {
        let nanoseconds = UInt64(timeInterval * 1_000_000_000)
        try? await Task.sleep(nanoseconds: nanoseconds)
    }
}
