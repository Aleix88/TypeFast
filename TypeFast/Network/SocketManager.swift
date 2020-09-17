//
//  SocketManager.swift
//  TypeFast
//
//  Created by Aleix Diaz Baggerman on 17/09/2020.
//  Copyright © 2020 Aleix Diaz Baggerman. All rights reserved.
//

import Foundation

enum SocketError: String, Error {
    case invalidSocketID = "Socket ID error"
    case unableToParseJSON = "Unable to parse JSON"
    case connectionError = "Socket connection error"
}

protocol SocketDelegate {
    func messageReceived(message: SocketData<String>)
}

class SocketManager {
    
    //MARK: Variables
    private var urlSession: URLSession?
    private var webSocketTask: URLSessionWebSocketTask?
    private var socketID: String?
    private var delegate: SocketDelegate?
    
    //MARK: Constants
    private let urlString = "ws://127.0.0.1:8080/connect"
    static let shared = SocketManager()
    
    //MARK: Init
    private init() {}
    
    //MARK: Functions
    
    func connectToServer() {
        guard let url = URL(string: self.urlString) else {return}
        self.urlSession = URLSession(configuration: .default)
        self.webSocketTask = self.urlSession?.webSocketTask(with: url)
        webSocketTask?.resume()
        
        webSocketTask?.receive(completionHandler: self.receiveMessage)
    }
    
    private func receiveMessage(result: Result<URLSessionWebSocketTask.Message, Error>) {
        switch result {
        case .failure(let error):
            print(error)
            break
        case .success(let message):
            self.handleMessage(message: message)
            break
        }
    }
    
    private func handleMessage(message: URLSessionWebSocketTask.Message) {
        let jsonParser = JSONHandler()
        switch message {
        case .string(let text):
            let socketData: SocketData<String>? = try? jsonParser.parseJSON(text: text)
            if  let data = socketData {
                self.delegate?.messageReceived(message: data)
            } else {
                self.socketID = text
            }
        default:
            break
        }
    }
    
    func sendMessage(messageType: MessageType, complention: @escaping (Result<String, Error>) -> ()) {
        guard let socketID = self.socketID else {
            complention(.failure(SocketError.invalidSocketID))
            return
        }
        let foo = SocketData<String>(clientID: socketID, messageType: messageType)
        guard let jsonData = try? JSONEncoder().encode(foo) else {
            complention(.failure(SocketError.unableToParseJSON))
            return
        }
        guard let jsonString = String(data: jsonData, encoding: .utf8) else {
            complention(.failure(SocketError.unableToParseJSON))
            return
        }
        
        let message = URLSessionWebSocketTask.Message.string(jsonString)
        self.webSocketTask?.send(message) { (error) in
            if let _ = error {
                complention(.failure(SocketError.connectionError))
            }
        }
    }
    
    
}
