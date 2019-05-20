//
//  Quiz.swift
//  iOSVjestina2019
//
//  Created by FIVE on 04/04/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//

import Foundation

class Quiz {
    let id: Int
    let title: String
    let description: String
    let category: Category
    let level: Int
    let imageURL: String
    let questions: [Question]
    
    init?(json: Any) {
        if let jsonDict = json as? [String: Any],
            let id = jsonDict["id"] as? Int,
            let title = jsonDict["title"] as? String,
            let description = jsonDict["description"] as? String,
            let categoryString = jsonDict["category"] as? String,
            let level = jsonDict["level"] as? Int,
            let imageURL = jsonDict["image"] as? String,
            let questions = jsonDict["questions"] as? [Any] {
                self.id = id
                self.title = title
                self.description = description
                self.level = level
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
