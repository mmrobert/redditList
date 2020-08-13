//
//  Result42.swift
//  RedditList
//
//  Created by boqian cheng on 2020-08-13.
//  Copyright © 2020 boqiancheng. All rights reserved.
//

import Foundation

// for swift 4.2 which has no "Result" type
enum Result42<Success, Failure> where Failure : Error {
    // A success, storing a 'Success' value.
    case success(Success)
    // A failure, storing a 'Failure' value.
    case failure(Failure)
}
