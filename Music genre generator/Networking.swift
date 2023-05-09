//
//  Networking.swift
//  Music genre generator
//
//  Created by user on 23.04.2023.
//

import Foundation

enum NetworkingError: Error {
    case notValidLink
    case notValidData
}

class Networking {
    static func load(_ request: String, completion: @escaping (String) -> (), errorCompletion: @escaping (NetworkingError) -> ()) {
        guard  let url = URL(string: request) else {
            errorCompletion(NetworkingError.notValidLink)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                errorCompletion(NetworkingError.notValidData)
                return
            }
            if let string = String(data: data, encoding: .utf8) {
                print(string)
                completion(string)
            }
        }
        task.resume()
    }
}
