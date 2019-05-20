//
//  QuestionView.swift
//  iOSVjestina2019
//
//  Created by FIVE on 11/04/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//

import UIKit

class QuestionView: UIView {
    
    var questionTextLabel: UILabel?
    var answerA: UIButton?
    var answerB: UIButton?
    var answerC: UIButton?
    var answerD: UIButton?
    var question: Question?
    
    weak var delegate: QuestionViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        let h = self.frame.size.height
        let w = self.frame.size.width
        
        questionTextLabel = UILabel(frame: CGRect(origin: CGPoint(x: w*0.05, y: w*0.02), size: CGSize(width: w*0.9, height: h*0.25)))
        questionTextLabel?.numberOfLines = 2
        questionTextLabel?.adjustsFontSizeToFitWidth = true
        questionTextLabel?.textAlignment = .center
        questionTextLabel?.text = "Question?"
        if let label = questionTextLabel {
            self.addSubview(label)
        }
        
        answerA = UIButton(frame: CGRect(origin: CGPoint(x: w*0.05, y: h*0.3), size: CGSize(width:w*0.4, height: h*0.3)))
        answerA?.setTitle("a", for: .normal)
        answerA?.titleLabel?.adjustsFontSizeToFitWidth = true
        answerA?.backgroundColor = UIColor.gray
        answerA?.tag = 0
        
        if let answer = answerA {
            self.addSubview(answer)
        }
        answerA?.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        answerB = UIButton(frame: CGRect(origin: CGPoint(x: w*0.55, y: h*0.3), size: CGSize(width:w*0.4, height: h*0.3)))
        answerB?.setTitle("b", for: .normal)
        answerB?.titleLabel?.adjustsFontSizeToFitWidth = true
        answerB?.backgroundColor = UIColor.gray
        answerB?.tag = 1

        if let answer = answerB {
            self.addSubview(answer)
        }
        answerB?.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        answerC = UIButton(frame: CGRect(origin: CGPoint(x: w*0.05, y: h*0.65), size: CGSize(width:w*0.4, height: h*0.3)))
        answerC?.setTitle("c", for: .normal)
        answerC?.titleLabel?.adjustsFontSizeToFitWidth = true
        answerC?.backgroundColor = UIColor.gray
        answerC?.tag = 2

        if let answer = answerC {
            self.addSubview(answer)
        }
        answerC?.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        answerD = UIButton(frame: CGRect(origin: CGPoint(x: w*0.55, y: h*0.65), size: CGSize(width:w*0.4, height: h*0.3)))
        answerD?.setTitle("d", for: .normal)
        answerD?.titleLabel?.adjustsFontSizeToFitWidth = true
        answerD?.backgroundColor = UIColor.gray
        answerD?.tag = 3

        if let answer = answerD {
            self.addSubview(answer)
        }
        answerD?.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        self.backgroundColor = UIColor.clear
    }
    
    @objc func buttonAction(sender: UIButton!) {
        delegate?.answerClicked(self, index: sender.tag)
    }
    
}

protocol QuestionViewDelegate: NSObjectProtocol {
    func answerClicked(_ questionView: QuestionView, index answer: Int)
}
