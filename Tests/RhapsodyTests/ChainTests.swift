@testable import Rhapsody
import XCTest

// Tests the >=> chain operator

fileprivate struct TestError: Error {}

final class ChainTests: XCTestCase {
  func testOptionalToOptionalFnsAllWithValue() {
    let f: (Int) -> Int? = { $0 + 1 }
    let g: (Int) -> Int? = { $0 * 2 }
    let h: (Int) -> Int? = { $0 - 1 }

    let chained = f >=> g >=> h
    XCTAssertEqual(chained(1), 3)
  }

  func testOptionalToOptionalFnsFirstNil() {
    let f: (Int) -> Int? = { _ in nil }
    let g: (Int) -> Int? = { $0 * 2 }
    let h: (Int) -> Int? = { $0 - 1 }

    let chained = f >=> g >=> h
    XCTAssertNil(chained(1))
  }

  func testOptionalToOptionalFnsSecondNil() {
    let f: (Int) -> Int? = { $0 + 1 }
    let g: (Int) -> Int? = { _ in nil }
    let h: (Int) -> Int? = { $0 - 1 }

    let chained = f >=> g >=> h
    XCTAssertNil(chained(1))
  }

  func testOptionalToOptionalFnsThirdNil() {
    let f: (Int) -> Int? = { $0 + 1 }
    let g: (Int) -> Int? = { $0 * 2 }
    let h: (Int) -> Int? = { _ in nil }

    let chained = f >=> g >=> h
    XCTAssertNil(chained(1))
  }

  // throwing

  func testOptionalToOptionalFnsAllWithValueThrowing() {
    let f: (Int) throws -> Int? = { $0 + 1 }
    let g: (Int) throws -> Int? = { $0 * 2 }
    let h: (Int) throws -> Int? = { $0 - 1 }

    let chained = f >=> g >=> h
    XCTAssertEqual(try chained(1), 3)
  }

  func testOptionalToOptionalFnsFirstNilThrowing() {
    let f: (Int) throws -> Int? = { _ in nil }
    let g: (Int) throws -> Int? = { $0 * 2 }
    let h: (Int) throws -> Int? = { $0 - 1 }

    let chained = f >=> g >=> h
    XCTAssertNil(try chained(1))
  }

  func testOptionalToOptionalFnsSecondNilThrowing() {
    let f: (Int) throws -> Int? = { $0 + 1 }
    let g: (Int) throws -> Int? = { _ in nil }
    let h: (Int) throws -> Int? = { $0 - 1 }

    let chained = f >=> g >=> h
    XCTAssertNil(try chained(1))
  }

  func testOptionalToOptionalFnsThirdNilThrowing() {
    let f: (Int) throws -> Int? = { $0 + 1 }
    let g: (Int) throws -> Int? = { $0 * 2 }
    let h: (Int) throws -> Int? = { _ in nil }

    let chained = f >=> g >=> h
    XCTAssertNil(try chained(1))
  }

  func testOptionalToOptionalFnsFirstThrows() {
    let f: (Int) throws -> Int? = { _ in throw TestError() }
    let g: (Int) throws -> Int? = { $0 * 2 }
    let h: (Int) throws -> Int? = { $0 - 1 }

    let chained = f >=> g >=> h
    XCTAssertThrowsError(try chained(1))
  }

  func testOptionalToOptionalFnsSecondThrows() {
    let f: (Int) throws -> Int? = { $0 + 1 }
    let g: (Int) throws -> Int? = { _ in throw TestError() }
    let h: (Int) throws -> Int? = { $0 - 1 }

    let chained = f >=> g >=> h
    XCTAssertThrowsError(try chained(1))
  }

  func testOptionalToOptionalFnsThirdThrows() {
    let f: (Int) throws -> Int? = { $0 + 1 }
    let g: (Int) throws -> Int? = { $0 * 2 }
    let h: (Int) throws -> Int? = { _ in throw TestError() }

    let chained = f >=> g >=> h
    XCTAssertThrowsError(try chained(1))
  }

  // optional to non-optional

  func testOptionalToNonOptionalFnsAllWithValue() {
    let f: (Int) -> Int? = { $0 + 1 }
    let g: (Int) -> Int = { $0 * 2 }

    let chained = f >=> g
    XCTAssertEqual(chained(1), 4)
  }

  func testOptionalToNonOptionalFnsFirstNil() {
    let f: (Int) -> Int? = { _ in nil }
    let g: (Int) -> Int = { _ in fatalError() }

    let chained = f >=> g
    XCTAssertNil(chained(1))
  }

  func testOptionalToNonOptionalFnsSecondNil() {
    let f: (Int) -> Int? = { $0 + 1 }
    let g: (Int) -> Int = { $0 * 2 }

    let chained = f >=> g
    XCTAssertEqual(chained(1), 4)
  }

  // Note: these should be deprecated, preferring `>>>`

  func testNonOptionalToOptionalFnsAllWithValue() {
    let f: (Int) -> Int = { $0 + 1 }
    let g: (Int) -> Int? = { $0 * 2 }

    let chained = f >=> g
    XCTAssertEqual(chained(1), 4)
  }

  func testNonOptionalToOptionalFnsWithNil() {
    let f: (Int) -> Int = { $0 + 1 }
    let g: (Int) -> Int? = { _ in nil }

    let chained = f >=> g
    XCTAssertNil(chained(1))
  }

  func testNonOptionalOutToNonOptionalInOutFn() {
    let f: (Int) -> Int = { $0 + 1 }
    let g: (Int) -> Int = { $0 * 2 }

    let chained = f >=> g
    XCTAssertEqual(chained(1), 4)
  }

  func testNonOptionalOutToOptionalIn() {
    let f: (Int) -> Int = { $0 + 1 }
    let g: (Int?) -> Int = { ($0 ?? 1) * 2 }

    let chained = f >=> g
    XCTAssertEqual(chained(1), 4)
  }
  
  func testNonOptionalOutToOptionalInAndOut() {
    let f: (Int) -> Int? = { $0 + 1 }
    let g: (Int?) -> Int? = { ($0 ?? 1) * 2 }

    let chained = f >=> g
    XCTAssertEqual(chained(1), 4)
  }

}
