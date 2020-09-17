//
//  File.swift
//  
//
//  Created by Aleix Diaz Baggerman on 16/09/2020.
//

import Foundation

final class SocketData<T:Codable>:Codable  {
    var clientID: String!
    var messageType: MessageType!
    var data: T?
    
    init(clientID: String, messageType: MessageType, data: T? = nil) {
        self.clientID = clientID
        self.messageType = messageType
        self.data = data
    }
}
