//
//  QuizzesViewModel.swift
//  iOSVjestina2019
//
//  Created by FIVE on 20/05/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//

import Foundation

struct QuizCellModel {
    let title: String
    let description: String
    let imageUrl: URL?
    
    init(quiz: Quiz) {
        self.title = quiz.title
        self.description = quiz.description
        self.imageUrl = URL(string: quiz.imageURL ?? "")
    }
}

class QuizzesViewModel {
    
    var groupedQuizzes: Dictionary<Category, [Quiz]>?
    var sections: [Category]?
    var quizzes: [Quiz]?
    
    func fetchQuizzes(completion: @escaping (() -> Void)) {

        QuizService().fetchQuizzes { (quizzes) in
            if let quizzes = quizzes {
                self.quizzes = quizzes
                self.groupedQuizzes = Dictionary(grouping: quizzes) { quiz in quiz.category }
                
                if let keys = self.groupedQuizzes?.keys {
                    self.sections = Array(keys)
                }
            }
            completion()
        }
    }
    
    func viewModel(atIndex index: Int, inSection section: Int) -> SingleQuizViewModel? {
        if let sections = sections {
            if section >= 0 && section < sections.count {
                if let groupedQuizzes = groupedQuizzes {
                    if let quizzes = groupedQuizzes[sections[section]] {
                        if index >= 0 && index < quizzes.count {
                            return SingleQuizViewModel(quiz: quizzes[index])
                        }
                    }
                }
            }
        }
        return nil
    }
    
    func quiz(atIndex index: Int, inSection section: Int) -> QuizCellModel? {
        let quizCellModel = QuizCellModel(quiz: self.groupedQuizzes![self.sections![section]]![index])
        return quizCellModel
    }
    
    func numberOfQuizzesInSection(numberOfRowsInSection section: Int) -> Int {
        
        if let groupedQuizzes = self.groupedQuizzes {
            return (groupedQuizzes[self.sections![section]]?.count)!
        }
        return 0
        
    }
    
    func numberOfSections() -> Int {
        return sections?.count ?? 0
    }

}
