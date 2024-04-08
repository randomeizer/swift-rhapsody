import XCTest
@testable import Rhapsody

// Tests the >>> (forward compose/pipe) operator

fileprivate struct TestError: Error {}

final class PipeTests: XCTestCase {
  func testPipeTwoFunctions() {
    let f: (Int) -> Int = { $0 + 1 }
    let g: (Int) -> Int = { $0 * 2 }
    
    let composed = f >>> g
    XCTAssertEqual(composed(1), 4)
  }
  
  func testPipeThreeFunctions() {
    let f: (Int) -> Int = { $0 + 1 }
    let g: (Int) -> Int = { $0 * 2 }
    let h: (Int) -> Int = { $0 - 2 }
    
    let composed = f >>> g >>> h
    XCTAssertEqual(composed(1), 2)
  }
  
  func testPipeFourFunctions() {
    let f: (Int) -> Int = { $0 + 1 }
    let g: (Int) -> Int = { $0 * 2 }
    let h: (Int) -> Int = { $0 - 2 }
    let i: (Int) -> Int = { $0 / 2 }
    
    let composed = f >>> g >>> h >>> i
    XCTAssertEqual(composed(1), 1)
  }
  
  func testPipeFiveFunctions() {
    let f: (Int) -> Int = { $0 + 1 }
    let g: (Int) -> Int = { $0 * 2 }
    let h: (Int) -> Int = { $0 - 2 }
    let i: (Int) -> Int = { $0 / 2 }
    let j: (Int) -> Int = { $0 * 3 }
    
    let composed = f >>> g >>> h >>> i >>> j
    XCTAssertEqual(composed(1), 3)
  }

  // test optionals in must pipe to optional out

  func testPipeTwoFunctionsWithOptionalsNotNil() {
    let f: (Int) -> Int = { $0 + 1 }
    let g: (Int) -> Int? = { $0 * 2 }
    
    let composed = f >>> g
    XCTAssertEqual(composed(1), 4)
  }

  func testPipeTwoFunctionsWithOptionalsFirstNil() {
    let f: (Int) -> Int? = { _ in nil }
    let g: (Int?) -> Int = { ($0 ?? 1) * 2 }

    let composed = f >>> g
    XCTAssertEqual(composed(1), 2)
  }
  
  func testPipeTwoFunctionsWithOptionalsSecondNil() {
    let f: (Int) -> Int = { $0 + 1 }
    let g: (Int) -> Int? = { _ in nil }

    let composed = f >>> g
    XCTAssertNil(composed(1))
  }
    
  func testPipeTwoFunctionsWithSecondOptionalIn() {
    let f: (Int) -> Int = { $0 + 1 }
    let g: (Int?) -> Int = { ($0 ?? 1) * 2 }

    let composed = f >>> g
    XCTAssertEqual(composed(1), 4)
  }

  // test throwing functions

  func testPipeTwoFunctionsThrowing() {
    let f: (Int) throws -> Int = { $0 + 1 }
    let g: (Int) throws -> Int = { $0 * 2 }
    
    let composed = f >>> g
    XCTAssertNoThrow(try composed(1))
    XCTAssertEqual(try? composed(1), 4)
  }

  func testPipeThreeFunctionsThrowing() {
    let f: (Int) throws -> Int = { $0 + 1 }
    let g: (Int) throws -> Int = { $0 * 2 }
    let h: (Int) throws -> Int = { $0 - 2 }
    
    let composed = f >>> g >>> h
    XCTAssertEqual(try composed(1), 2)
  }

  // test throwing functions with optionals

  func testPipeTwoFunctionsThrowingWithOptionals() {
    let f: (Int) throws -> Int = { $0 + 1 }
    let g: (Int?) throws -> Int = { ($0 ?? 1) * 2 }
    
    let composed = f >>> g
    XCTAssertEqual(try composed(1), 4)
  }

  // actually throw

  func testPipeTwoFunctionsThrowingWithOptionalsFirstNil() {
    let f: (Int) throws -> Int? = { _ in throw TestError() }
    let g: (Int?) -> Int = { ($0 ?? 1) * 2 }

    let composed = f >>> g
    XCTAssertThrowsError(try composed(1))
  }
}
