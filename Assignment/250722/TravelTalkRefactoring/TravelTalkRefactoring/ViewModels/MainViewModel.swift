//
//  MainViewModel.swift
//  TravelTalkRefactoring
//
//  Created by 서준일 on 7/22/25.
//

import Foundation

final class MainViewModel {
    
    private var chatRooms: [ChatRoom] = []
    private var filteredChatRooms: [ChatRoom] = []
    
    var onDataUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    
    private var isFiltering = false
    
    var count: Int {
        return isFiltering ? filteredChatRooms.count : chatRooms.count
    }
    
    func fetchData() {
        chatRooms = ChatList.list
        filteredChatRooms = chatRooms
        
        onDataUpdated?()
    }
    
    func chatRoom(at index: Int) -> ChatRoom {
        return isFiltering ? filteredChatRooms[index] : chatRooms[index]
    }
    
    func searchChatRooms(with keyword: String) {
        if keyword.isEmpty {
            isFiltering = false
            filteredChatRooms = chatRooms
        } else {
            isFiltering = true
            filteredChatRooms = chatRooms.filter {
                $0.chatroomName.contains(keyword)
            }
        }
        
        onDataUpdated?()
    }
}
