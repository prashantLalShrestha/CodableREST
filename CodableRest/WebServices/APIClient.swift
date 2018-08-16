//
//  APIClient.swift
//  Pay2Nepal
//
//  Created by Inficare Pvt. Ltd. on 21/06/2018.
//  Copyright © 2018 Inficare. All rights reserved.
//

import Foundation

public class APIClient {
    private let baseEndpoint = WebService.baseUrl + "/"
    private let session = URLSession(configuration: .default)
    
    public var shouldPrint: Bool = false
    
    public func send<T: APIRequest>(_ request: T, completion: @escaping ResultCallback<T.Response>) {
        let endPoint = self.endPoint(for: request)
        
        let task = session.dataTask(with: URLRequest(url: endPoint)) { data, response, error in
            if let data = data {
                if self.shouldPrint {
                    print("\(request.requestName) Response: \(data)")
                    let string1 = String(data: data, encoding: String.Encoding.utf8) ?? "Data could not be printed"
                    print("\(string1)\n")
                }
                do {
                    let response = try JSONDecoder().decode(T.Response.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(APIError.decoding))
                }
            } else if error != nil {
                completion(.failure(APIError.server))
            }
        }
        task.resume()
    }
    
    private func endPoint<T: APIRequest>(for request: T) -> URL {
        guard let parameters = try? URLQueryEncoder.encode(request) else { fatalError("Wrong parameters") }
        
        return URL(string: "\(baseEndpoint)\(request.requestName)?params=\(parameters)")!
    }
}
