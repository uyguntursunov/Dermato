//
//  MessageModel.swift
//  Curify
//
//

import UIKit

struct MessageModel: Codable {
    let id: Int
    let user_id: String?
    let is_AI: Bool
    let message: String?
    let sent_at: String?
}

struct ResponseModel: Codable {
    let response: String?
}

struct Message {
    let text: String?
    let type: MessageType
}

enum MessageType {
    case sended
    case recieved
}
