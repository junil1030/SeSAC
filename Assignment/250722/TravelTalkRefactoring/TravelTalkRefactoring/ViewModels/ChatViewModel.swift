//
//  ChatViewModel.swift
//  TravelTalkRefactoring
//
//  Created by 서준일 on 7/22/25.
//

import Foundation

enum ChatCase {
    case message(Chat)
    case dateSeparator(String)
}

class ChatViewModel {
    
    private var chatRoom: ChatRoom
    private var filteredChatData: [ChatCase] = []
    
    var onDataUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    
    init(chatRoom: ChatRoom) {
        self.chatRoom = chatRoom
        setupChatCases()
    }
    
    var numberOfItems: Int {
        return filteredChatData.count
    }
    
    var chatRoomName: String {
        return chatRoom.chatroomName
    }
    
    func chatCase(at index: Int) -> ChatCase {
        return filteredChatData[index]
    }
    
    func addMessage(_ text: String) {
         let newChat = Chat(user: ChatList.me, date: Date().toStringFormat(), message: text)
         chatRoom.chatList.append(newChat)
         
         let newDate = newChat.date.dateFormatted(to: .yyyyMMdd)
         
         // 필터링된 데이터에서 마지막 데이터를 뽑아서
         if let lastData = filteredChatData.last {
             switch lastData {
             case .message(let lastChat):
                 let lastDate = lastChat.date.dateFormatted(to: .yyyyMMdd)
                 
                 // 다를 경우 날짜 구분선을 추가
                 if newDate != lastDate {
                     filteredChatData.append(.dateSeparator(newDate))
                 }
             case .dateSeparator(let lastDateString):
                 // 새 메시지 날짜와 비교
                 if newDate != lastDateString {
                     filteredChatData.append(.dateSeparator(newDate))
                 }
             }
         } else {
             filteredChatData.append(.dateSeparator(newDate))
         }
         
         filteredChatData.append(.message(newChat))

         onDataUpdated?()
     }
    
    private func setupChatCases() {
        filteredChatData = []
        var lastDate = ""
        
        for chat in chatRoom.chatList {
            let currentDate = chat.date.dateFormatted(to: .yyyyMMdd)
            
            if currentDate != lastDate {
                filteredChatData.append(.dateSeparator(currentDate))
                lastDate = currentDate
            }
            
            filteredChatData.append(.message(chat))
        }
    }
}
