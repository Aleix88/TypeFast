//
//  File.swift
//  
//
//  Created by Aleix Diaz Baggerman on 16/09/2020.
//

import Foundation

enum MessageType: Int {
    case joinRoom = 0
    case createRoom = 1
    case joinRoomError = 2
    case wordCompleted = 3
    case matchWin = 4
    case matchLose = 5
}

extension MessageType: Codable {
    
    enum Key: CodingKey {
        case rawValue
    }
    
    enum CodingError: Error {
        case unknownValue
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let rawValue = try container.decode(Int.self, forKey: .rawValue)
        switch rawValue {
        case 0:
            self = .joinRoom
        case 1:
            self = .createRoom
        case 2:
            self = .joinRoomError
        case 3:
            self = .wordCompleted
        case 4:
            self = .matchWin
        case 5:
            self = .matchLose
        default:
            throw CodingError.unknownValue
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        switch self {
        case .joinRoom:
            try container.encode(0, forKey: .rawValue)
        case .createRoom:
            try container.encode(1, forKey: .rawValue)
        case .joinRoomError:
            try container.encode(2, forKey: .rawValue)
        case .wordCompleted:
            try container.encode(3, forKey: .rawValue)
        case .matchWin:
            try container.encode(4, forKey: .rawValue)
        case .matchLose:
            try container.encode(5, forKey: .rawValue)
        }
    }
    
}
