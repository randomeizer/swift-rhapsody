import XCTest
@testable import Rhapsody

// Tests the <<< (backward compose) operator

fileprivate struct TestError: Error {}

final class BackwardComposeTests: XCTestCase {
  func testComposeTwoFunctions() {
    let f: (Int) -> Int = { $0 + 1 }
    let g: (Int) -> Int = { $0 * 2 }
    
    let composed = f <<< g
    XCTAssertEqual(composed(1), 3)
  }
  
  func testComposeThreeFunctions() {
    let f: (Int) -> Int = { $0 + 1 }
    let g: (Int) -> Int = { $0 * 2 }
    let h: (Int) -> Int = { $0 - 1 }
    
    let composed = f <<< g <<< h
    XCTAssertEqual(composed(1), 1)
  }
  
  func testComposeFourFunctions() {
    let f: (Int) -> Int = { $0 + 1 }
    let g: (Int) -> Int = { $0 * 2 }
    let h: (Int) -> Int = { $0 - 1 }
    let i: (Int) -> Int = { $0 / 2 }
    
    let composed = f <<< g <<< h <<< i
    XCTAssertEqual(composed(1), -1)
  }
  
  func testComposeFiveFunctions() {
    let f: (Int) -> Int = { $0 + 1 }
    let g: (Int) -> Int = { $0 * 2 }
    let h: (Int) -> Int = { $0 - 1 }
    let i: (Int) -> Int = { $0 / 2 }
    let j: (Int) -> Int = { $0 * 3 }
    
    let composed = f <<< g <<< h <<< i <<< j
    XCTAssertEqual(composed(1), 1)
  }

  // test optionals out must pipe to optional in

  func testPipeTwoFunctionsWithOptionalsNotNil() {
    let f: (Int?) -> Int? = { ($0 ?? 0) + 1 }
    let g: (Int) -> Int? = { $0 * 2 }
    
    let composed = f <<< g
    XCTAssertEqual(composed(1), 3)
  }

  func testPipeTwoFunctionsWithOptionalsFirstNil() {
    let f: (Int?) -> Int? = { _ in nil }
    let g: (Int) -> Int? = { $0 * 2 }
    
    let composed = f <<< g
    XCTAssertNil(composed(1))
  }

  // test throwing functions

  func testComposeTwoThrowingFunctionsNoError() {
    let f: (Int) throws -> Int = { $0 + 1 }
    let g: (Int) throws -> Int = { $0 * 2 }
    
    let composed = f <<< g
    XCTAssertEqual(try composed(1), 3)
  }

  func testComposeTwoThrowingFunctionsWithError() {
    let f: (Int) throws -> Int = { _ in throw TestError() }
    let g: (Int) throws -> Int = { $0 * 2 }
    
    let composed = f <<< g
    XCTAssertThrowsError(try composed(1))
  }
}
