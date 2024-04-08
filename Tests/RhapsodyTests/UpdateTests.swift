import XCTest

@testable import Rhapsody

// Tests the |> (inplace applicator/update) operator

private struct TestError: Error {}

final class UpdateTests: XCTestCase {
  func testUpdateOneFunction() {
    let f: (inout Int) -> Void = { $0 += 1 }

    var x = 1
    x |> f
    XCTAssertEqual(x, 2)
  }

  func testUpdateTwoFunctions() {
    let f: (inout Int) -> Void = { $0 += 1 }
    let g: (inout Int) -> Void = { $0 *= 2 }

    var x = 1
    x |> f <> g
    XCTAssertEqual(x, 4)
  }

  func testUpdateThreeFunctions() {
    let f: (inout Int) -> Void = { $0 += 1 }
    let g: (inout Int) -> Void = { $0 *= 2 }
    let h: (inout Int) -> Void = { $0 -= 2 }

    var x = 1
    x |> f <> g <> h
    XCTAssertEqual(x, 2)
  }
}
