//
//  DataSourceRepoTests.swift
//  RedditListTests
//
//  Created by boqian cheng on 2020-08-13.
//  Copyright © 2020 boqiancheng. All rights reserved.
//

import XCTest
@testable import RedditList

class DataSourceRepoTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoadLeagues() {
        
        let expectation = XCTestExpectation(description: "Fetching posts.")
        
        let dataSourceRepo = DataSourceRepo.shared
        dataSourceRepo.addListener { (result) in
            switch result {
            case .success(let posts):
                XCTAssert(posts.count > 0, "No post was loaded.")
            case .failure(let err):
                XCTFail("Datasource Error: " + "\(err)")
            }
            
            expectation.fulfill()
        }
        dataSourceRepo.fetchPosts()
        
        wait(for: [expectation], timeout: 10.0)
    }
}

