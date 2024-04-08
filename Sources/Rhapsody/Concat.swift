import Overture

/// Composes an array of functions that take and return the same type.
///
/// - Parameters:
///   - fs: Zero or more functions to apply in order.
/// - Returns: A new function that applies every function given as input in order.
/// - Note: This function is commonly seen in operator form as `<>`.
@inlinable
func <> <A>(lhs: @escaping (A) -> A, rhs: @escaping (A) -> A) -> (A) -> A {
    return concat([lhs, rhs])
}

// overload for functions that throw
@inlinable
func <> <A>(lhs: @escaping (A) throws -> A, rhs: @escaping (A) throws -> A) -> (A) throws -> A {
    return concat([lhs, rhs])
}

// overloads for situations where one function throws and the other does not

@inlinable
func <> <A>(lhs: @escaping (A) -> A, rhs: @escaping (A) throws -> A) -> (A) throws -> A {
    return concat([lhs, rhs])
}

@inlinable
func <> <A>(lhs: @escaping (A) throws -> A, rhs: @escaping (A) -> A) -> (A) throws -> A {
    return concat([lhs, rhs])
}

// overloads for functions that take an inout and return Void

@inlinable
func <> <A>(lhs: @escaping (inout A) -> Void, rhs: @escaping (inout A) -> Void) -> (inout A) -> Void {
    return concat([lhs, rhs])
}

// overload for functions that throw

@inlinable
func <> <A>(lhs: @escaping (inout A) throws -> Void, rhs: @escaping (inout A) throws -> Void) -> (inout A) throws -> Void {
    return concat([lhs, rhs])
}

// overloads for situations where one function throws and the other does not

@inlinable
func <> <A>(lhs: @escaping (inout A) -> Void, rhs: @escaping (inout A) throws -> Void) -> (inout A) throws -> Void {
    return concat([lhs, rhs])
}

@inlinable
func <> <A>(lhs: @escaping (inout A) throws -> Void, rhs: @escaping (inout A) -> Void) -> (inout A) throws -> Void {
    return concat([lhs, rhs])
}

// overloads for functions that take a reference type and return void

@inlinable
func <> <A: AnyObject>(lhs: @escaping (A) -> Void, rhs: @escaping (A) -> Void) -> (A) -> Void {
    return concat([lhs, rhs])
}

// overload for functions that throw

@inlinable
func <> <A: AnyObject>(lhs: @escaping (A) throws -> Void, rhs: @escaping (A) throws -> Void) -> (A) throws -> Void {
    return concat([lhs, rhs])
}

// overloads for situations where one function throws and the other does not

@inlinable
func <> <A: AnyObject>(lhs: @escaping (A) -> Void, rhs: @escaping (A) throws -> Void) -> (A) throws -> Void {
    return concat([lhs, rhs])
}
