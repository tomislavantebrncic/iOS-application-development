//
//  Question.swift
//  iOSVjestina2019
//
//  Created by FIVE on 04/04/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//

import Foundation

class Question {
    
    let question: String
    let answers: [String]
    let correctAnswer: Int
    
    init?(json: Any) {
        if let jsonDict = json as? [String: Any],
            let question = jsonDict["question"] as? String,
            let answers = jsonDict["answers"] as? [String],
            let correctAnswer = jsonDict["correct_answer"] as? Int {
                self.question = question
                self.answers = answers
                self.correctAnswer = correctAnswer
        } else {
            return nil
        }
    }
    
}
