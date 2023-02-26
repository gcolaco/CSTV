//
//  CSTVTests.swift
//  CSTVTests
//
//  Created by Gustavo Colaço on 25/02/23.
//

import XCTest
@testable import CSTV

final class CSTVTests: XCTestCase {
    private let sut = NetworkingMock()
    
    func testNeworking() {

        let emptyUpcommingArray = sut.upcommingMatches
        XCTAssertTrue(emptyUpcommingArray.isEmpty, "Array is empty")

        let emptyRunningArray = sut.upcommingMatches
        XCTAssertTrue(emptyRunningArray.isEmpty, "Array is empty")
        
        NetworkManager.shared.getUpcomingMatches(page: 1) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let matches):
                self.sut.upcommingMatches.append(contentsOf: matches)
                XCTAssertTrue(!self.sut.upcommingMatches.isEmpty, "Array is empty")
            case .failure(let error):
                print("ERROR: \(error.rawValue)")
            }
        }
        
        NetworkManager.shared.getRunningMatches { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let matches):
                self.sut.runningMatches.append(contentsOf: matches)
                XCTAssertTrue(!self.sut.runningMatches.isEmpty, "Array is empty")
            case .failure(let error):
                print("ERROR: \(error.rawValue)")
            }
        }
    }
    
}


class NetworkingMock {
    var upcommingMatches: [Matches] = []
    var runningMatches: [Matches] = []
    
}
