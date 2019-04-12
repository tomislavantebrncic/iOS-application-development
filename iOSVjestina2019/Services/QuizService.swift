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
    
}
