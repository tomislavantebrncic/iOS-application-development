//
//  Category.swift
//  iOSVjestina2019
//
//  Created by FIVE on 04/04/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//

import Foundation
import UIKit

enum Category : String {
    case sports
    case science
    
    var color: UIColor {
        switch self {
        case .sports:
            return UIColor.green
        case .science:
            return UIColor.cyan
        }
    }
    
    static func getCategory(string: String) -> Category? {
        switch string {
        case "SPORTS":
            return .sports
        case "SCIENCE":
            return .science
        default:
            return nil
        }
    }
}
