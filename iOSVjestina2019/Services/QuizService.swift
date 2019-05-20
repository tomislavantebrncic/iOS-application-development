//
//  QuizService.swift
//  iOSVjestina2019
//
//  Created by FIVE on 04/04/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//

import Foundation
import UIKit

class QuizService {
    
    func fetchQuizzes(completion: @escaping (([Quiz]?) -> Void)) {
        let urlString = "https://iosquiz.herokuapp.com/api/quizzes"
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let jsonDict = json as? [String: [Any]],
                            let quizzes = jsonDict["quizzes"] {
                            var quizzesArray = [Quiz]()
                            for i in 0..<quizzes.count {
                                if let quiz = Quiz(json: quizzes[i]) {
                                    quizzesArray.append(quiz)
                                }
                            }
//                            let sections = Set(quizzesArray.compactMap({quiz in quiz.category})).count
                            completion(quizzesArray)
                        } else {
                            completion(nil)
                        }
                    } catch {
                        completion(nil)
                    }
                } else {
                    completion(nil)
                }
            }
            dataTask.resume()
        } else {
            completion(nil)
        }
    }
    
    func fetchQuizz(completion: @escaping ((Quiz?, Int?) -> Void)) {
        let urlString = "https://iosquiz.herokuapp.com/api/quizzes"
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let jsonDict = json as? [String: [Any]],
                            let quizzes = jsonDict["quizzes"] {
                            let count = quizzes.compactMap { value in Quiz(json: value)?.questions }.joined().filter { question in question.question.contains("NBA")}.count
                                let quiz = Quiz(json: quizzes[Int(arc4random_uniform(UInt32(quizzes.count)))])
                                completion(quiz, count)
                        } else {
                            completion(nil, nil)
                        }
                    } catch {
                        completion(nil, nil)
                    }
                } else {
                    completion(nil, nil)
                }
            }
            dataTask.resume()
        } else {
            completion(nil, nil)
        }
    }
    
    func fetchImage(urlString: String, completion: @escaping ((UIImage?) -> Void)) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    let image = UIImage(data: data)
                    completion(image)
                } else {
                    completion(nil)
                }
                
            }
            
            dataTask.resume()
        } else {
            completion(nil)
        }
        
    }
    
    func sendData(parameters: [String: Any], completion: @escaping ((Bool) -> Void)) {
        let url = URL(string: "https://iosquiz.herokuapp.com/api/result")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(UserDefaults.standard.string(forKey: "token"), forHTTPHeaderField: "Authorization")
        
        request.httpBody = parameters.percentEscaped().data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {                                              // check for fundamental networking error
                    print("error", error ?? "Unknown error")
                    completion(false)
                    return
            }
            
            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                completion(false)
                return
            }
            
            completion(true)
        }
        
        task.resume()
    }
}
