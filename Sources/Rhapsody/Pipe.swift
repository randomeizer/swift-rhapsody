import Overture

infix operator >>>: infixr9

/// Forware composition of functions. Useful for chaining operations.
///     
///    let chars2url: (UnsafePointer<CChar>) -> URL = String.init(validatingUTF8:) >>> URL.init(string:)
///
/// - Parameters:
///   - f: The first function
///   - g: The second function
/// - Returns: A new function that pipes the output of the first function into the input of the second function
@inlinable
public func >>> <A, B, C>(
  _ f: @escaping (A) -> B,
  _ g: @escaping (B) -> C
  )
  -> (A) -> C {
  pipe(f, g)
}

// overload for functions that throw
@inlinable
public func >>> <A, B, C>(
  _ f: @escaping (A) throws -> B,
  _ g: @escaping (B) throws -> C
  )
  -> (A) throws -> C {
  pipe(f, g)
}

// overloads for situations where one function throws and the other does not

@inlinable
public func >>> <A, B, C>(
  _ f: @escaping (A) -> B,
  _ g: @escaping (B) throws -> C
  )
  -> (A) throws -> C {
  pipe(f, g)
}

@inlinable
public func >>> <A, B, C>(
  _ f: @escaping (A) throws -> B,
  _ g: @escaping (B) -> C
  )
  -> (A) throws -> C {
  pipe(f, g)
}
