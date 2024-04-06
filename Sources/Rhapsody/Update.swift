import Overture

infix operator |>: infixl1

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
  _ fs: (inout A) throws -> Void
  ) rethrows {
  try update(&a, fs)
}
