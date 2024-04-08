import Overture

// use Overture.chain 

/// Forward composition of functions that return optionals. Useful for chaining operations that may fail.
///
/// ```swift
/// let chars2url: (UnsafePointer<CChar>) -> URL? = String.init(validatingUTF8:) >=> URL.init(string:))
/// ```
///
/// - Parameters:
///   - f: A function that takes a value in `A` and returns an optional value in `B`.
///   - g: A function that takes a value in `B` and returns an optional value in `C`.
/// - Returns: A new function that takes a value in `A` and returns an optional value in `C`.
/// - Note: This function is commonly seen in operator form as `>=>`.
@inlinable
public func >=> <A, B, C>(
  _ f: @escaping (A) -> B?,
  _ g: @escaping (B) -> C?
  )
  -> (A) -> C? {
  chain(f, g)
}

// overload for functions that throw

@inlinable
public func >=> <A, B, C>(
  _ f: @escaping (A) throws -> B?,
  _ g: @escaping (B) throws -> C?
  )
  -> (A) throws -> C? {
  chain(f, g)
}

// overloads for situations where one function throws and the other does not

@inlinable
public func >=> <A, B, C>(
  _ f: @escaping (A) -> B?,
  _ g: @escaping (B) throws -> C?
  )
  -> (A) throws -> C? {
  chain(f, g)
}

@inlinable
public func >=> <A, B, C>(
  _ f: @escaping (A) throws -> B?,
  _ g: @escaping (B) -> C?
  )
  -> (A) throws -> C? {
  chain(f, g)
}
