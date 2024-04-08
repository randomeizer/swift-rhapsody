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
@_disfavoredOverload
public func >=> <A, B, C>(
  _ f: @escaping (A) throws -> B?,
  _ g: @escaping (B) throws -> C?
  )
  -> (A) throws -> C? {
  chain(f, g)
}

// overloads for combinations of optional and non-optional functions

@inlinable
public func >=> <A, B, C>(
  _ f: @escaping (A) -> B?,
  _ g: @escaping (B) -> C
  )
  -> (A) -> C? {
  chain(f, g)
}

@inlinable
public func >=> <A, B, C>(
  _ f: @escaping (A) -> B?,
  _ g: @escaping (B) throws -> C
  )
  -> (A) throws -> C? {
  chain(f, g)
}

@inlinable
public func >=> <A, B, C>(
  _ f: @escaping (A) -> B,
  _ g: @escaping (B?) throws -> C
  )
  -> (A) throws -> C? {
  chain(f, g)
}

// Deprecated when left functions return non-optional values, encourage use of >>>

@inlinable
@available(*, deprecated, renamed: ">>>", message: "prefer >>> (forward-compose) when functions return non-optional values")
public func >=> <A, B, C>(
  _ f: @escaping (A) -> B,
  _ g: @escaping (B) -> C
)
-> (A) -> C? {
  chain(f, g)
}

@inlinable
@available(*, deprecated, renamed: ">>>", message: "prefer >>> (forward-compose) when functions return non-optional values")
public func >=> <A, B, C>(
  _ f: @escaping (A) -> B,
  _ g: @escaping (B?) -> C
)
-> (A) -> C? {
  chain(f, g)
}

@inlinable
@available(*, deprecated, renamed: ">>>", message: "prefer >>> (forward-compose) when left-hand function output matches right-hand function input")
public func >=> <A, B, C>(
  _ f: @escaping (A) -> B,
  _ g: @escaping (B) -> C?
)
-> (A) -> C? {
  chain(f, g)
}

@inlinable
@available(*, deprecated, renamed: ">>>", message: "prefer >>> (forward-compose) when left-hand function returns non-optional value")
public func >=> <A, B, C>(
  _ f: @escaping (A) throws -> B,
  _ g: @escaping (B) throws -> C?
)
-> (A) throws -> C? {
  chain(f, g)
}
