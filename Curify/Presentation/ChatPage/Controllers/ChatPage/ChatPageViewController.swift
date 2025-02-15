//
//  ChatPageViewController.swift
//  Curify
//
//

import UIKit

class ChatPageViewController: BaseViewController, ChatControllerDelegate {
    
    var isLoading: Bool = false {
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var subView = SubView(frame: .zero)
    
    var messages = [Message]() {
        didSet {
            isEmpty = messages.count == 0
        }
    }
    
    var isEmpty: Bool = false {
        didSet {
            noMessagesLabel.isHidden = !isEmpty
        }
    }
    
    lazy var noMessagesLabel: Label = {
       let label = Label(font: .systemFont(ofSize: 17, weight: .medium))
        label.text = "noMessages".translate()
        return label
    }()
    
    lazy var bottomSendView: ChatBottomSendView = {
        let view = ChatBottomSendView()
        view.delegate = self
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(ChatSenderTableViewCell.self, forCellReuseIdentifier: String.init(describing: ChatSenderTableViewCell.self))
        tableView.register(ChatReceiverTableViewCell.self, forCellReuseIdentifier: String.init(describing: ChatReceiverTableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        initViews()
        addObservers()
        getChatHistory()
        hideKeyboardWhenTappedAround()
    }
    
    private func initViews() {
        title = "chatWithAI".translate()
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(bottomSendView)
        
        bottomSendView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        subView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(bottomSendView.snp.top)
        }
        
        subView.addSubview(noMessagesLabel)
        noMessagesLabel.snp.makeConstraints { make in
            make.center.centerY.equalToSuperview()
        }
    }
    
    func sendMessage(_ message: String, lang: String) {
        isLoading = true
        API.shared.sendRequest(message: message, lang: lang) { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let data):
                if let response = data.response {
                    self?.insertCell(str: response, type: .recieved)
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    func getChatHistory() {
        showLoadingView()
        API.shared.getChatHistory { [weak self] result in
            self?.dismissLoadingView()
            switch result {
            case .success(let data):
                self?.setData(data)
                self?.tableView.reloadData()
                self?.scrollToBottom()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func setData(_ conversations: [MessageModel]) {
        for conversation in conversations {
            var type: MessageType = .sended
            if conversation.is_AI {
                type = .recieved
            } else {
                type = .sended
            }
            messages.append(Message(text: conversation.message, type: type))
            isEmpty = messages.count == 0
        }
    }
    
    func sendButtonTapped() {
        if let newMessage = bottomSendView.getText(), !newMessage.replacingOccurrences(of: " ", with: "").isEmpty {
            let lang = getCurrentLanguage()
            sendMessage(newMessage, lang: lang)
            insertCell(str: newMessage, type: .sended)
            bottomSendView.setText("")
        }
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    
    @objc func viewTapped() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            UIView.animate(withDuration: 0.3) {
                self.bottomSendView.snp.updateConstraints { make in
                    make.bottom.equalToSuperview().offset(-keyboardHeight + self.getBottomMargin())
                }
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.bottomSendView.snp.updateConstraints { make in
                make.bottom.equalToSuperview().offset(0)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardDidShow(_ notification: Notification) {
        scrollToBottom()
    }
    
    func scrollToBottom() {
        if tableView.numberOfRows(inSection: 0) - 1 <= 0 { return }
        let lastIndexPath = IndexPath(row: tableView.numberOfRows(inSection: 0) - 1, section: 0)
        tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
    }
    
    func insertCell(str: String, type: MessageType) {
        messages.append(Message(text: str, type: type))
        let newIndexPath = IndexPath(row: messages.count - 1, section: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [newIndexPath], with: .fade)
        tableView.endUpdates()
        tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
    }
    
    override func languageDidChange() {
        title = "chatWithAI".translate()
        noMessagesLabel.text = "noMessages".translate()
        bottomSendView.textField.placeholder = "message".translate()
        tableView.reloadData()
    }
}

extension ChatPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        switch message.type {
        case .sended:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String.init(describing: ChatSenderTableViewCell.self), for: indexPath) as? ChatSenderTableViewCell else { return UITableViewCell() }
            cell.setData(text: message.text ?? "")
            return cell
        case .recieved:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String.init(describing: ChatReceiverTableViewCell.self), for: indexPath) as? ChatReceiverTableViewCell else { return UITableViewCell() }
            cell.isLoading = isLoading
            cell.setData(text: message.text ?? "")
            return cell
        }
    }
}
