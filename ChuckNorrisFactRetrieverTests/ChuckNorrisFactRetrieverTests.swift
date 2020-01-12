//
//  ChuckNorrisFactRetrieverTests.swift
//  ChuckNorrisFactRetrieverTests
//
//  Created by Pedro Azevedo on 07/01/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import XCTest
@testable import ChuckNorrisFactRetriever

class ChuckNorrisFactRetrieverTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testRandomAPI(){
        
        var testFact:Fact!
       
        let anonymousFunc = {(fetchedData:Fact) in
                testFact = fetchedData
            XCTAssertNotNil(testFact, "Returned a fact")
                   XCTAssert(type(of: testFact) == Fact.self, "Fact conforms to test class")
        }
        api.ramdomfetch(urlStr: dao.randomUrl, onCompletion: anonymousFunc)
    }
    
    func testSearchAPI(){
        var searchedFact:FactSearch!
        
        let anonymousFunc = {(fetchedData:FactSearch) in
            searchedFact = fetchedData
            XCTAssertNotNil(searchedFact, "Returned a fact")
            XCTAssert(type(of: searchedFact) == FactSearch.self, "Result conforms to FactSearch class")
        }
        api.searchFetch(text: "coffee", onCompletion: anonymousFunc)
    }
    


    
    
    
    
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
