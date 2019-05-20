//
//  ServerResponse.swift
//  iOSVjestina2019
//
//  Created by FIVE on 20/05/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//

import Foundation

enum ServerResponse {
    case UNATHORIZED(Int)
    case FORBIDDEN(Int)
    case NOT_FOUND(Int)
    case BAD_REQUEST(Int)
    case OK(Int)
}
