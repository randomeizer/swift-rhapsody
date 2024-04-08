import Overture

/// Left-to-right, in-place function application.
///
///     var user = User(name: "Blob")
///     user |> { $0.name = "Blob Jr." }
///
/// - Parameters:
///   - a: A mutable value.
///   - fs: In-out functions.
/// - Note: This function is commonly seen in operator form as "pipe-forward", `|>`.
@inlinable
public func |> <A>(
  _ a: inout A,
  _ fs: (inout A) -> Void
  ) {
  fs(&a)
}

// overload for throwing functions

@inlinable
public func |> <A>(
  _ a: inout A,
  _ fs: (inout A) throws -> Void
  ) throws {
  try fs(&a)
}

// overload for reference types

@inlinable
public func |> <A: AnyObject>(
  _ a: A,
  _ fs: @escaping (A) -> Void
  ) {
  fs(a)
}

// overload for throwing functions

@inlinable
public func |> <A: AnyObject>(
  _ a: A,
  _ fs: @escaping (A) throws -> Void
  ) throws {
  try fs(a)
}
