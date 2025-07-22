//
//  ChatViewController.swift
//  TravelTalkRefactoring
//
//  Created by 서준일 on 7/22/25.
//

import UIKit
import SnapKit

class ChatViewController: UIViewController, UISetupProtocol{
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var inputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }()
    
    private lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "메세지를 입력하세요"
        let sendButton = UIButton(type: .system)
        sendButton.setImage(UIImage(systemName: "location"), for: .normal)
        sendButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        textField.rightView = sendButton
        textField.rightViewMode = .always
        textField.delegate = self
        textField.returnKeyType = .send
        return textField
    }()
    
    private let viewModel: ChatViewModel
    private var bottomConstraint: NSLayoutConstraint?

    init(chatRoom: ChatRoom) {
        self.viewModel = ChatViewModel(chatRoom: chatRoom)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
        setupActions()
        bindViewModel()
        registerCells()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        scrollToBottom()
    }
    
    deinit {
        removeKeyboardObservers()
    }
    
    private func bindViewModel() {
        viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.scrollToBottom()
            }
        }
    }
    
    private func registerCells() {
        tableView.register(MyMessageCell.self, forCellReuseIdentifier: MyMessageCell.identifier)
        tableView.register(OtherMessageCell.self, forCellReuseIdentifier: OtherMessageCell.identifier)
        tableView.register(DateCell.self, forCellReuseIdentifier: DateCell.identifier)
    }
    
    func setupUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = viewModel.chatRoomName
        
        view.addSubview(tableView)
        view.addSubview(inputContainerView)
        inputContainerView.addSubview(inputTextField)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide.snp.horizontalEdges)
            make.bottom.equalTo(inputContainerView.snp.top)
        }
        
        inputContainerView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.snp.horizontalEdges)
            make.height.equalTo(60)
        }
        
        inputContainerView.snp.makeConstraints { make in
            bottomConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).constraint.layoutConstraints.first
        }
        
        inputTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(inputContainerView).inset(16)
            make.centerY.equalTo(inputContainerView)
            make.height.equalTo(40)
        }
    }
    
    func setupActions() {
        setupKeyboardObservers()
        setupKeyboardDismiss()
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func scrollToBottom() {
        guard viewModel.numberOfItems > 0 else { return }
        
        let lastRow = viewModel.numberOfItems - 1
        let indexPath = IndexPath(row: lastRow, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    private func setupKeyboardDismiss() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        tableView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        
        let keyboardHeight = keyboardFrame.height
        
        inputContainerView.snp.updateConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-keyboardHeight)
        }
        
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.scrollToBottom()
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        
        inputContainerView.snp.updateConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }

    @objc private func sendButtonTapped() {
        guard let text = inputTextField.text, !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        viewModel.addMessage(text)
        inputTextField.text = ""
    }
}

extension ChatViewController: UITableViewDelegate {

}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chatCase = viewModel.chatCase(at: indexPath.row)
        
        switch chatCase {
        case .dateSeparator(let dateString):
            let cell = tableView.dequeueReusableCell(withIdentifier: DateCell.identifier, for: indexPath) as! DateCell
            cell.configure(with: dateString)
            return cell
            
        case .message(let chat):
            if chat.user.name == ChatList.me.name {
                let cell = tableView.dequeueReusableCell(withIdentifier: MyMessageCell.identifier, for: indexPath) as! MyMessageCell
                cell.configure(with: chat)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: OtherMessageCell.identifier, for: indexPath) as! OtherMessageCell
                cell.configure(with: chat)
                return cell
            }
        }
    }
}

extension ChatViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            viewModel.addMessage(text)
            inputTextField.text = ""
        }
        return true
    }
}
