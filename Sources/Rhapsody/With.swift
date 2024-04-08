import Overture

/// Left-to-right function application.
///
///     user |> getName // getName(user)
///
/// - Parameters:
///   - a: A value.
///   - f: A function.
/// - Returns: The result of `f` applied to `a`.
@inlinable
public func |> <A, B>(
  _ a: A,
  _ f: (A) -> B
  ) -> B {
  with(a, f)
}

// overload for functions that throw

@inlinable
public func |> <A, B>(
  _ a: A,
  _ f: (A) throws -> B
  ) throws -> B {
  try with(a, f)
}