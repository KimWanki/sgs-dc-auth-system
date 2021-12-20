//
//  NetworkServiceManager.swift
//  authSystemClient
//
//  Created by wankikim-MN on 2021/12/19.
//

import Foundation

protocol Sessionable {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: Sessionable { }

class NetworkServiceManager {
    
    let session: Sessionable
    let baseUrl = "http://localhost:3000"
    
    static let shared = NetworkServiceManager()
    
    private init(_ session: Sessionable = URLSession.shared ) {
        self.session = session
    }
    
    func handleResponse(for request: URLRequest,
                        completionHandler: @escaping ((Result<Codable, Error>) -> Void)) {
        
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let unwrappedResponse = response as? HTTPURLResponse else { completionHandler(.failure(NetworkingError.InvalidResponse))
                    return
                }
                print(unwrappedResponse.statusCode)
                
                switch unwrappedResponse.statusCode {
                case 200..<300:
                    #if DEBUG
                    print("Success")
                    #endif
                default:
                    #if DEBUG
                    print("Fail")
                    #endif
                }
                
                if let unwrappedError = error {
                    completionHandler(.failure(unwrappedError))
                    return
                }
                
                if let unwrappedData = data {
                    do {
                        if let tokenInfo = try? JSONDecoder().decode(UserInfo.self, from: unwrappedData) {
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
    
    func handleAdminResponse(for request: URLRequest,
                        completionHandler: @escaping ((Result<Codable, Error>) -> Void)) {
        
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let unwrappedResponse = response as? HTTPURLResponse else { completionHandler(.failure(NetworkingError.InvalidResponse))
                    return
                }
                print(unwrappedResponse.statusCode)
                
                switch unwrappedResponse.statusCode {
                case 200..<300:
                    #if DEBUG
                    print("Success")
                    #endif
                default:
                    #if DEBUG
                    print("Fail")
                    #endif
                }
                if let unwrappedError = error {
                    completionHandler(.failure(unwrappedError))
                    return
                }
                if let unwrappedData = data {
                    do {
                        if let tokenInfo = try? JSONDecoder().decode([PrivateInfo].self, from: unwrappedData) {
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
    
    func handleSignupResponse(for request: URLRequest,
                        completionHandler: @escaping ((Result<Codable, Error>) -> Void)) {
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
            }
        }
        task.resume()
    }
    
    func handleExistResponse(for request: URLRequest,
                        completionHandler: @escaping ((Result<Codable, Error>) -> Void)) {
        
//        let session = URLSession.shared
        
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
                    completionHandler(.success(true))
                    return
                default:
                    completionHandler(.failure(NetworkingError.InvalidResponse))
                }
            }
        }
        task.resume()
    }
        
    // 아이디 중복 체크 요청
    func request(endpoint: String,
                 checkObject: String,
                 completionHandler: @escaping (Result<Codable, Error>) -> Void) {
        guard let url = URL(string: baseUrl + endpoint + checkObject) else { completionHandler(.failure(NetworkingError.InvalidURL))
            return
        }
        var request = URLRequest(url: url)
        print(url)
        request.httpMethod = String(describing: HttpMethod.get)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        handleExistResponse(for: request, completionHandler: completionHandler)
    }
        
    // 로그인 요청
    func request(endpoint: String,
                 signinObject: SigninModel,
                 completionHandler: @escaping (Result<Codable, Error>) -> Void) {
        guard let url = URL(string: baseUrl + endpoint) else { completionHandler(.failure(NetworkingError.InvalidURL))
            return
        }
        
        var request = URLRequest(url: url)

        do {
            let loginData = try JSONEncoder().encode(signinObject)
            request.httpBody = loginData
        } catch {
            completionHandler(.failure(NetworkingError.EncodingFail))
        }

        request.httpMethod = String(describing: HttpMethod.post)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        handleResponse(for: request, completionHandler: completionHandler)
    }
    
    func request(endpoint: String,
                 completionHandler: @escaping (Result<Codable, Error>) -> Void) {
        guard let url = URL(string: baseUrl + endpoint) else { completionHandler(.failure(NetworkingError.InvalidURL))
            return
        }
        var request = URLRequest(url: url)
        
        request.httpMethod = String(describing: HttpMethod.get)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        handleAdminResponse(for: request, completionHandler: completionHandler)
    }
    
    // 회원 가입 요청
    func request(endpoint: String,
                 signupObject: SignupModel,
                 completionHandler: @escaping (Result<Codable, Error>) -> Void) {
        guard let url = URL(string: baseUrl + endpoint) else { completionHandler(.failure(NetworkingError.InvalidURL))
            return
        }
        
        var request = URLRequest(url: url)

        do {
            let signupData = try JSONEncoder().encode(signupObject)
            request.httpBody = signupData
        } catch {
            completionHandler(.failure(NetworkingError.EncodingFail))
        }
        
        request.httpMethod = String(describing: HttpMethod.post)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        handleSignupResponse(for: request, completionHandler: completionHandler)
    }
    
    // parameters을 활용한 네트워크 요청
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
            let queryItem = URLQueryItem(name: key, value: String(describing: value))
            queryItems.append(queryItem)
        }
        
        print(queryItems)
        components.queryItems = queryItems
    
        let queryItemData = components.query?.data(using: .utf8)
        
        request.httpBody = queryItemData
        request.httpMethod = String(describing: HttpMethod.post)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        handleSignupResponse(for: request, completionHandler: completionHandler)
    }
}
