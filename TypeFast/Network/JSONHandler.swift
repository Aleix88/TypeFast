//
//  JSONHandler.swift
//  TypeFast
//
//  Created by Aleix Diaz Baggerman on 17/09/2020.
//  Copyright © 2020 Aleix Diaz Baggerman. All rights reserved.
//

import Foundation

class JSONHandler {
    
    func parseJSON<T>(text: String) throws -> T? where T:Decodable {
        guard let data = text.data(using: .utf8) else {
            return nil
        }
        let object: T = try JSONDecoder().decode(T.self, from: data)
        return object
    }
    
}
