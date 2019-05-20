//
//  QuizTableViewCell.swift
//  iOSVjestina2019
//
//  Created by FIVE on 02/05/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//

//import UIKit
//
//class QuizTableViewCell: UITableViewCell {
//
//    var quizPicture: UIImageView?
//    var quizTitle: UILabel?
//    var quizDescription: UILabel?
//    
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        commonInit()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        
//        commonInit()
//    }
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
//    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        
//        // Configure the view for the selected state
//    }
//    
//    func commonInit() {
//        let h = self.frame.size.height
//        let w = self.frame.size.width
//        print("Dodajem cell")
//        quizTitle = UILabel(frame: CGRect(origin: CGPoint(x: w*0.05, y: w*0.02), size: CGSize(width: w*0.9, height: h*0.25)))
//        quizTitle?.adjustsFontSizeToFitWidth = true
//        quizTitle?.textAlignment = .center
//        quizTitle?.text = "Question?"
//        if let label = quizTitle {
//            self.addSubview(label)
//        }
//    }
//
//}
