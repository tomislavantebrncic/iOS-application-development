//
//  SingleQuizViewModel.swift
//  iOSVjestina2019
//
//  Created by FIVE on 20/05/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//

import Foundation

class SingleQuizViewModel {
    var quiz: Quiz? = nil
    var index = 0
    
    init(quiz: Quiz) {
        self.quiz = quiz
    }
    
    var title: String {
        return quiz?.title ?? ""
    }
    
    var imageUrl: URL? {
        if let urlString = quiz?.imageURL {
            return URL(string: urlString)
        }
        return nil
    }
    
    func hasNext() -> Bool {
        return (quiz?.questions.count)! > index
    }
    
    func next() -> Question {
        index += 1
        return (quiz?.questions[index-1])!
    }
    
    func get() -> Question {
        return (quiz?.questions[index-1])!
    }
}
