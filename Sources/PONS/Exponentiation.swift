//
//  Exponentiation.swift -- the `**` operator, declared by PONS itself.
//
//  BigNumOperators and ComplexOperators each declare `**` too, and two
//  operator declarations -- however identical -- cannot be imported into
//  the same file: every use site becomes ambiguous.  PONS therefore
//  declares the operator exactly once here and provides the overloads
//  for the whole menagerie; do NOT import either Operators module
//  alongside PONS.
//
import BigNum
import Complex

/// Binds tighter than `*`, and to the right, so `2 ** 3 ** 2` is `2 ** 9`.
/// Both match ordinary mathematical notation, and Python.
precedencegroup ExponentiationPrecedence {
    associativity: right
    higherThan: MultiplicationPrecedence
}

infix operator ** : ExponentiationPrecedence

// MARK: - integers: b.power(e)

/// `Int`, `UInt`, `Int8` ... `UInt64`.  Traps on overflow, as `power` and `*`
/// both do -- `2 ** 1024` is not a number an `Int` has.
public func ** <T:FixedWidthInteger>(_ base: T, _ exponent: Int) -> T {
    return base.power(exponent)
}

/// `BigInt` and `BigUInt`, where nothing overflows.
public func ** <T:BigIntegerType>(_ base: T, _ exponent: Int) -> T {
    return base.power(exponent)
}

// MARK: - floating point: pow(b, e)

/// `Double`, `Float`, `BigRat` and `BigFloat` -- every `RMath`.  The
/// arbitrary-precision two work to `Self.precision` bits; call
/// `pow(_:_:precision:)` directly when you want to say how many.
public func ** <T:RMath>(_ base: T, _ exponent: T) -> T {
    return T.pow(base, exponent)
}

/// An integer exponent, which is exact where the general form would iterate:
/// this is `pow(x, n)`, not `pow(x, T(n))`.
public func ** <T:Real>(_ base: T, _ exponent: Int) -> T {
    return T.pow(base, exponent)
}

// MARK: - complex: pow(b, e)

public func ** <Z:CMath>(_ base: Z, _ exponent: Z) -> Z {
    return Z.pow(base, exponent)
}
public func ** <Z:CMath>(_ base: Z, _ exponent: Z.Element) -> Z {
    return Z.pow(base, exponent)
}
public func ** <Z:CMath>(_ base: Z.Element, _ exponent: Z) -> Z {
    return Z.pow(base, exponent)
}
