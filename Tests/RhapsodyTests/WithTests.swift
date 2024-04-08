import XCTest
@testable import Rhapsody

// Test the `|>` (with) operator

fileprivate struct TestError: Error {}

final class WithTests: XCTestCase {
  func testWithNonThrowingFunction() {
    let f: (Int) -> Int = { $0 * 2 }
    
    XCTAssertEqual(1 |> f, 2)
  }

  func testWithThrowingFunction() {
    let f: (Int) throws -> Int = { _ in throw TestError() }
    
    XCTAssertThrowsError(try 1 |> f)
  }

  // to a new type

  func testWithNonThrowingFunctionToNewType() {
    let f: (Int) -> String = { "\($0)!" }
    
    XCTAssertEqual(1 |> f, "1!")
  }

  // using >>> to compose functions

  func testWithNonThrowingFunctionWithCompose() {
    let f: (Int) -> Int = { $0 + 1 }
    let g: (Int) -> Int = { $0 * 2 }
    
    XCTAssertEqual(1 |> f >>> g, 4)
  }
}
