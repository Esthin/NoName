//
//  ImageLoaderServiceTests.swift

//
//  Created by Dmitry Kosyakov on 18.12.2022.
//

import XCTest
@testable import NoName

class ImageLoaderServiceTests: XCTestCase {
    
    var mockTaskFactory: CountableDataTaskFactoryMock!
    var imageLoadingService: ImageLoadingService!
    var lock: NSLock!
    var recieveDataCount = 0
    
    override func setUp() {
        mockTaskFactory = CountableDataTaskFactoryMock(delay: 0.1)
        imageLoadingService = ImageLoadingService(taskFactory: mockTaskFactory)
        lock = NSLock()
    }
    
    override func tearDown() {
        imageLoadingService = nil
        mockTaskFactory = nil
        lock = nil
    }
    
    func test_operations_count() {
        let expectation = expectation(description: "operations")
        let group = DispatchGroup()
        let count = 10
        DispatchQueue.concurrentPerform(iterations: count) { _ in
            group.enter()
            self.imageLoadingService.loadImage(with: URL(string: "test")!) { [weak self] result in
                group.leave()
                self?.lock.lock()
                self?.recieveDataCount += 1
                self?.lock.unlock()
            }
        }
        
        group.notify(queue: .main) {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(mockTaskFactory.getResponseCallCount, 1)
        XCTAssertEqual(recieveDataCount, count)
    }
    
    func test_different_operations_count() {
        let expectation = expectation(description: "operations")
        let group = DispatchGroup()
        let count = 10
        DispatchQueue.concurrentPerform(iterations: count) { value in
            group.enter()
            self.imageLoadingService.loadImage(with: URL(string: value.description)!) { [weak self] result in
                group.leave()
                self?.lock.lock()
                self?.recieveDataCount += 1
                self?.lock.unlock()
            }
        }
        
        group.notify(queue: .main) {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(mockTaskFactory.getResponseCallCount, count)
        XCTAssertEqual(recieveDataCount, count)
    }
    
}
