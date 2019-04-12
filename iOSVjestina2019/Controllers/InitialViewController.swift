//
//  InitialViewController.swift
//  iOSVjestina2019
//
//  Created by FIVE on 10/04/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    @IBOutlet weak var fetchButton: UIButton!
    @IBOutlet weak var funFactLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var questionViewContainer: UIView!
    
    var questionView: QuestionView?
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        fetchQuiz()
    }
    
    func fetchQuiz() {
        let quizService = QuizService()
        
        quizService.fetchQuizz { (quiz, count) in
            DispatchQueue.main.async {
                if let quiz = quiz, let count = count {
                    self.errorLabel.isHidden = true
                    self.funFactLabel.text = "Fun Fact: There are " + String(count) + " questions about NBA"
                    self.funFactLabel.sizeToFit()
                    self.funFactLabel.center.x = self.view.center.x
                    self.titleLabel.text = quiz.title
                    self.titleLabel.sizeToFit()
                    self.titleLabel.center.x = self.view.center.x
                    quizService.fetchImage(urlString: quiz.imageURL, completion: { (image) in
                        DispatchQueue.main.async {
                            self.pictureImageView.image = image
                                self.pictureImageView.center.x = self.view.center.x
                        }
                    })
                    self.titleLabel.backgroundColor = quiz.category.color
                    self.pictureImageView.backgroundColor = quiz.category.color
                    
                    self.addQuestionView(quiz: quiz)
                } else {
                    self.errorLabel.isHidden = false
                }
            }
        }
    }
    
    func addQuestionView(quiz: Quiz) {
        
        let question = quiz.questions[Int(arc4random_uniform(UInt32(quiz.questions.count)))]
        // stvaramo jedan CustomView objekt sa 'frame' konstruktorom, dakle dajemo mu okvir unutar kojeg ce se iscrtati
        if let qView = questionView {
            qView.questionTextLabel?.text = question.question
            qView.answerA?.setTitle(question.answers[0], for: .normal)
            qView.answerB?.setTitle(question.answers[1], for: .normal)
            qView.answerC?.setTitle(question.answers[2], for: .normal)
            qView.answerD?.setTitle(question.answers[3], for: .normal)
            qView.question = question
        } else {
            questionView = QuestionView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: questionViewContainer.frame.width, height: questionViewContainer.frame.height)))
            
            questionView?.questionTextLabel?.text = question.question
            questionView?.answerA?.setTitle(question.answers[0], for: .normal)
            questionView?.answerB?.setTitle(question.answers[1], for: .normal)
            questionView?.answerC?.setTitle(question.answers[2], for: .normal)
            questionView?.answerD?.setTitle(question.answers[3], for: .normal)
            questionView?.question = question
            
            questionViewContainer.addSubview(questionView!)
            questionViewContainer.center.x = self.view.center.x
            
            questionView?.answerA?.addTarget(self, action: #selector(InitialViewController.buttonClicked), for: .touchUpInside)
            questionView?.answerB?.addTarget(self, action: #selector(InitialViewController.buttonClicked), for: .touchUpInside)
            questionView?.answerC?.addTarget(self, action: #selector(InitialViewController.buttonClicked), for: .touchUpInside)
            questionView?.answerD?.addTarget(self, action: #selector(InitialViewController.buttonClicked), for: .touchUpInside)
        }
    }
    
    @objc func buttonClicked(sender: UIButton!) {
        if sender === questionView?.answerA {
            if questionView?.question?.correctAnswer == 0 {
                UIView.animate(withDuration: 2, animations: { sender.backgroundColor = UIColor.green }, completion: {_ in sender.backgroundColor = UIColor.gray })
            } else {
                UIView.animate(withDuration: 1, animations: { sender.backgroundColor = UIColor.red }, completion: {_ in sender.backgroundColor = UIColor.gray })
            }
        } else if sender === questionView?.answerB {
            if questionView?.question?.correctAnswer == 1 {
                UIView.animate(withDuration: 2, animations: { sender.backgroundColor = UIColor.green }, completion: {_ in sender.backgroundColor = UIColor.gray })
            } else {
                UIView.animate(withDuration: 1, animations: { sender.backgroundColor = UIColor.red }, completion: {_ in sender.backgroundColor = UIColor.gray })
            }
        } else if sender === questionView?.answerC {
            if questionView?.question?.correctAnswer == 2 {
                UIView.animate(withDuration: 2, animations: { sender.backgroundColor = UIColor.green }, completion: {_ in sender.backgroundColor = UIColor.gray })
            } else {
                UIView.animate(withDuration: 1, animations: { sender.backgroundColor = UIColor.red }, completion: {_ in sender.backgroundColor = UIColor.gray })
            }
        } else if sender === questionView?.answerD {
            if questionView?.question?.correctAnswer == 3 {
                UIView.animate(withDuration: 2, animations: { sender.backgroundColor = UIColor.green }, completion: {_ in sender.backgroundColor = UIColor.gray })
            } else {
                UIView.animate(withDuration: 1, animations: { sender.backgroundColor = UIColor.red }, completion: {_ in sender.backgroundColor = UIColor.gray })
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
