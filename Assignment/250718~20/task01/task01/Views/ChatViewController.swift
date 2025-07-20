//
//  ChatViewController.swift
//  task01
//
//  Created by 서준일 on 7/20/25.
//

import UIKit

enum ChatCase {
    case message(Chat)
    case dateSeparator(String)
}

class ChatViewController: UIViewController {
    
    static let identifier = "ChatViewController"

    @IBOutlet var tableView: UITableView!
    @IBOutlet var inputTextField: UITextField!
    
    var chatRoomData: ChatRoom?
    private var filteredChatRoomData: [ChatCase] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        setupChatCases()
        registerXib()
        
        dump(filteredChatRoomData)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = chatRoomData?.chatroomName
        
        inputTextField.placeholder = "메세지를 입력하세요"
        
        let sendButton = UIButton(type: .system)
        sendButton.setImage(UIImage(systemName: "location"), for: .normal)
        sendButton.tintColor = CustomColor.grayColor
        sendButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)

        inputTextField.rightView = sendButton
        inputTextField.rightViewMode = .always
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        scrollToBottom()
    }
    
    private func setupChatCases() {
        guard let chatData = chatRoomData else { return }
        
        filteredChatRoomData = []
        var lastDate = ""
        
        for chat in chatData.chatList {
            let currentDate = chat.date.dateFormatted(to: .yyyyMMdd)
            
            if currentDate != lastDate {
                filteredChatRoomData.append(.dateSeparator(currentDate))
                lastDate = currentDate
            }
            
            filteredChatRoomData.append(.message(chat))
        }
    }
    
    private func registerXib() {
        let myXib = UINib(nibName: MyMessageTableViewCell.identifier, bundle: nil)
        tableView.register(myXib, forCellReuseIdentifier: MyMessageTableViewCell.identifier)
        
        let otherXib = UINib(nibName: OtherMessageTableViewCell.identifier, bundle: nil)
        tableView.register(otherXib, forCellReuseIdentifier: OtherMessageTableViewCell.identifier)
        
        let dateXib = UINib(nibName: DateTableViewCell.identifier, bundle: nil)
        tableView.register(dateXib, forCellReuseIdentifier: DateTableViewCell.identifier)
    }
    
    private func scrollToBottom() {
        let lastRow = filteredChatRoomData.count - 1
        let indexPath = IndexPath(row: lastRow, section: 0)
        
        print(lastRow, indexPath)
        
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
    }
    
    private func addText(_ text: String) {
        let newChat = Chat(user: ChatList.me, date: Date().toStringFormat(), message: text)
        chatRoomData?.chatList.append(newChat)
        
        let newDate = newChat.date.dateFormatted(to: .yyyyMMdd)
        
        // 필터링된 데이터에서 마지막 데이터를 뽑아서
        if let lastData = filteredChatRoomData.last {
            switch lastData {
                // 메세지일 경우, 메세지 날짜와 추가한 채팅 날짜를 비교
            case .message(let lastChat):
                let lastDate = lastChat.date.dateFormatted(to: .yyyyMMdd)
                
                // 다를 경우 날짜 구분선을 추가
                if newDate != lastDate {
                    filteredChatRoomData.append(.dateSeparator(newDate))
                }
                // 마지막이 날짜 구분선일 경우 (이 경우가 보통 없을 것 같긴 한데..)
            case .dateSeparator(let lastDateString):
                // 새 메시지 날짜와 비교
                if newDate != lastDateString {
                    filteredChatRoomData.append(.dateSeparator(newDate))
                }
            }
        } else {
            filteredChatRoomData.append(.dateSeparator(newDate))
        }
        
        filteredChatRoomData.append(.message(newChat))
        
        inputTextField.text = ""
        tableView.reloadData()
//        tableView.layoutIfNeeded()
        scrollToBottom()
    }
    
    @objc private func sendButtonTapped() {
        print(#function)
        guard let text = inputTextField.text, !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }

        addText(text)
    }
}

extension ChatViewController: UITableViewDelegate {
    
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredChatRoomData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chatData = filteredChatRoomData[indexPath.row]
        
        switch chatData {
        case .dateSeparator(let dateString) :
            let cell = tableView.dequeueReusableCell(withIdentifier: DateTableViewCell.identifier, for: indexPath) as! DateTableViewCell
            cell.dateLabel.text = dateString
            return cell
            
        case .message(let chat):
            if chat.user.name == ChatList.me.name {
                let cell = tableView.dequeueReusableCell(withIdentifier: MyMessageTableViewCell.identifier, for: indexPath) as! MyMessageTableViewCell
                cell.messageLabel.text = chat.message
                cell.timeLabel.text = chat.date.dateFormatted(to: .hmma)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: OtherMessageTableViewCell.identifier, for: indexPath) as! OtherMessageTableViewCell
                cell.messageLabel.text = chat.message
                cell.nameLabel.text = chat.user.name
                cell.profileImageView.image = UIImage(named: chat.user.image)
                cell.timeLabel.text = chat.date.dateFormatted(to: .hmma)
                return cell
            }
        }
    }
}
