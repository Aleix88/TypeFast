//
//  NetworkError.swift
//  TypeFast
//
//  Created by Aleix Diaz Baggerman on 15/09/2020.
//  Copyright © 2020 Aleix Diaz Baggerman. All rights reserved.
//

import Foundation


enum NetworkError: String, Error {
    case unableToComplete = "Error: Unable to complete this request."
    case invalidResponse = "Error: The given response wasn't valid."
    case invalidData = "Error: The data sended by the server wasn't valid"
    case invalidURL = "Error: Invalid URL"
}
