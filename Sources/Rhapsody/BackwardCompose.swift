import Overture

/// Backward composition of functions.
///
/// - Parameters:
///   - f: A function that takes a value in `B` and returns a value in `C`.
///   - b: An argument in `B`.
///   - g: A function that takes a value in `A` and returns a value in `B`.
///   - a: An argument in `A`.
/// - Returns: A new function that takes a value in `A` and returns a value in `C`.
/// - Note: This function is commonly seen in operator form as `<<<`.
@inlinable
public func <<< <A, B, C>(
  _ f: @escaping (B) -> C,
  _ g: @escaping (A) -> B
  )
  -> (A) -> C {
  compose(f, g)
}

@inlinable
public func <<< <A, B, C>(
  _ f: @escaping (B) throws -> C,
  _ g: @escaping (A) throws -> B
  )
  -> (A) throws -> C {
  compose(f, g)
}
