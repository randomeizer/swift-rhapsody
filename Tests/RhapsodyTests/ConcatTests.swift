import XCTest
@testable import Rhapsody

final class ConcatTests: XCTestCase {
  func testConcatTwoFunctions() {
    let f: (Int) -> Int = { $0 + 1 }
    let g: (Int) -> Int = { $0 * 2 }

    let fn = f <> g
    XCTAssertEqual(fn(1), 4)
  }

  func testConcatThreeFunctions() {
    let f: (Int) -> Int = { $0 + 1 }
    let g: (Int) -> Int = { $0 * 2 }
    let h: (Int) -> Int = { $0 - 2 }

    let fn = f <> g <> h
    XCTAssertEqual(fn(1), 2)
  }
}
