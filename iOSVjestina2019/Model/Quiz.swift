//
//  Quiz.swift
//  iOSVjestina2019
//
//  Created by FIVE on 04/04/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//

import Foundation

class Quiz {
    
    let title: String
    let category: Category
    let imageURL: String
    let questions: [Question]
    
    init?(json: Any) {
        if let jsonDict = json as? [String: Any],
            let title = jsonDict["title"] as? String,
            let categoryString = jsonDict["category"] as? String,
            let imageURL = jsonDict["image"] as? String,
            let questions = jsonDict["questions"] as? [Any] {
                self.title = title
                self.imageURL = imageURL
                switch categoryString {
                case "SPORTS":
                    self.category = .sports
                    break
                case "SCIENCE":
                    self.category = .science
                    break
                default:
                    return nil
                }
                self.questions = questions.compactMap { value in Question(json: value)}
        } else {
            return nil
        }
    }
    
}
