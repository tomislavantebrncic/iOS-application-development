//
//  SingleQuizViewController.swift
//  iOSVjestina2019
//
//  Created by FIVE on 20/05/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//

import UIKit

class SingleQuizViewController: UIViewController, QuestionViewDelegate {
    
    func answerClicked(_ questionView: QuestionView, index answer: Int) {
        let q = viewModel.get()
        print(answer, q.correctAnswer)
        print(q.question)
        if q.correctAnswer == answer {
            correct_answers += 1
            questionView.backgroundColor = UIColor.green
        } else {
            questionView.backgroundColor = UIColor.red
        }
        if viewModel.hasNext() {
            viewModel.next()
            let x = questionsScrollView.contentOffset.x + questionsScrollView.frame.width
            let y = questionsScrollView.contentOffset.y
            questionsScrollView.setContentOffset(CGPoint(x: x, y: y), animated: true)
        } else {
            finish()
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var questionsScrollView: UIScrollView!
        
    var viewModel: SingleQuizViewModel!
   
    var startTime: NSDate?
    var correct_answers = 0
    
    convenience init(viewModel: SingleQuizViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    @IBAction func start(_ sender: UIButton) {
        if viewModel.index == 0 {
            startTime = NSDate()
            questionsScrollView.isHidden = false
            viewModel.hasNext()
            viewModel.next()
        }
       
    }
    
    func bindViewModel() {
        titleLabel.text = viewModel.title
        titleLabel.sizeToFit()
        titleLabel.textAlignment = .center
        titleLabel.center.x = self.view.center.x
        URLSession.shared.dataTask(with: viewModel.imageUrl!) { (data, response, error) in
            let image = UIImage(data: data!)
            DispatchQueue.main.async {
                self.pictureImageView.image = image
            }
            }.resume()
        questionsScrollView.isHidden = true
        questionsScrollView.delaysContentTouches = false
        var index = 0
        var subviews = viewModel.quiz?.questions.map {(question) -> QuestionView in
            var questionView = QuestionView(frame: CGRect(origin: CGPoint(x: index*Int(questionsScrollView.frame.width), y: 0), size: CGSize(width: questionsScrollView.frame.width, height: questionsScrollView.frame.height)))
            questionView.answerA?.setTitle(question.answers[0], for: .normal)
            questionView.answerB?.setTitle(question.answers[1], for: .normal)
            questionView.answerC?.setTitle(question.answers[2], for: .normal)
            questionView.answerD?.setTitle(question.answers[3], for: .normal)
            questionView.question = question
            questionView.questionTextLabel?.text = question.question
            questionView.delegate = self
            index += 1
            return questionView
        }
        
        subviews?.enumerated().forEach{ (index, subview) in
            questionsScrollView.addSubview(subview)
        }
        
    }
    
    func finish() {
        let now = NSDate()
        let timePassed = now.timeIntervalSince(startTime as! Date)
        
        let parameters: [String: Any] = [
            "quiz_id": viewModel.quiz!.id,
            "user_id": UserDefaults.standard.string(forKey: "user_id"),
            "time": timePassed,
            "no_of_correct": correct_answers
        ]
        
        QuizService().sendData(parameters: parameters) {_ in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
            
        }

        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
        print("kraj kviza ", timePassed)
    }

}



