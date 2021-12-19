//
//  NetworkServiceManager.swift
//  authSystemClient
//
//  Created by wankikim-MN on 2021/12/19.
//

import Foundation

class NetworkServiceManager {
    let baseUrl = "http://localhost:3000"
    
    func handleResponse(for request: URLRequest,
                        completionHandler: @escaping ((Result<Codable, Error>) -> Void)) {
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let unwrappedResponse = response as? HTTPURLResponse else { completionHandler(.failure(NetworkingError.InvalidResponse))
                    return
                }
                print(unwrappedResponse.statusCode)
                
                switch unwrappedResponse.statusCode {
                // success
                case 200..<300:
                    // pass into our api
                    print("success")
                default:
                    print("failure")
                }
                
                if let unwrappedError = error {
                    completionHandler(.failure(unwrappedError))
                    return
                }
                
                if let unwrappedData = data {
                    do {
                        if let tokenInfo = try? JSONDecoder().decode(JWT.self, from: unwrappedData) {
                            completionHandler(.success(tokenInfo))
                        } else {
                            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: unwrappedData)
                            completionHandler(.failure(errorResponse))
                        }
                    } catch {
                        completionHandler(.failure(error))
                    }
                }
            }
        }
        task.resume()
        
    }
    
    func request(endpoint: String,
                 parameters: [String: Any],
                 completionHandler: @escaping (Result<Codable, Error>) -> Void) {
        guard let url = URL(string: baseUrl + endpoint) else { completionHandler(.failure(NetworkingError.InvalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        var components = URLComponents()
        var queryItems = [URLQueryItem]()
        for (key, value) in parameters {
            // any value to string
            let queryItem = URLQueryItem(name: key, value: String(describing: value))
            queryItems.append(queryItem)
        }
        
        components.queryItems = queryItems
        // username=IDvalue & password=passwordValue
        // standard encoding for request
        let queryItemData = components.query?.data(using: .utf8)
        
        print(components.url)
        request.httpBody = queryItemData
        request.httpMethod = String(describing: HttpMethod.post)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        handleResponse(for: request, completionHandler: completionHandler)
    }
    
    
    func request(endpoint: String,
                 loginObject: SigninModel,
                 completionHandler: @escaping (Result<Codable, Error>) -> Void) {
        guard let url = URL(string: baseUrl + endpoint) else { completionHandler(.failure(NetworkingError.InvalidURL))
            return
        }
        
        var request = URLRequest(url: url)

        do {
            let loginData = try JSONEncoder().encode(loginObject)
            request.httpBody = loginData
        } catch {
            completionHandler(.failure(NetworkingError.EncodingFail))
        }
        
        // username=IDvalue & password=passwordValue
        // standard encoding for request
        request.httpMethod = String(describing: HttpMethod.post)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        handleResponse(for: request, completionHandler: completionHandler)
    }
    
    func request(endpoint: String,
                 joinObject: SignupModel,
                 completionHandler: @escaping (Result<Codable, Error>) -> Void) {
        guard let url = URL(string: baseUrl + endpoint) else { completionHandler(.failure(NetworkingError.InvalidURL))
            return
        }
        
        var request = URLRequest(url: url)

        do {
            let loginData = try JSONEncoder().encode(joinObject)
            request.httpBody = loginData
        } catch {
            completionHandler(.failure(NetworkingError.EncodingFail))
        }
        
        // username=IDvalue & password=passwordValue
        // standard encoding for request
        request.httpMethod = String(describing: HttpMethod.post)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        handleResponse(for: request, completionHandler: completionHandler)
    }
    
}
