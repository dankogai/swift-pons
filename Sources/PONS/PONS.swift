

// imported and re-exported
//
// cf. https://github.com/apple/swift/blob/master/docs/Modules.rst#modules-can-re-export-other-modules

// import everything
@_exported import BigNum
@_exported import Complex
@_exported import Int2X
// @_exported import Interval
// import just a protocol


// BigRat and BigFloat become Complex-ready elements here, where both
// packages meet: swift-complex only conforms its own Double and Float,
// and swift-bignum knows nothing of Complex.  The conformances are empty
// because RMath was designed around swift-bignum's vocabulary -- the
// plain math functions and their precision:debug: forms witness every
// requirement as-is, at the arbitrary precision they natively carry.
extension BigRat:   @retroactive RMath {}
extension BigFloat: @retroactive RMath {}

// Int128 ... Int1024 are all Int2X<Word>, so the conformance is declared
// once, on the generic type -- per-typealias extensions would be so many
// conditional conformances of the same type to the same protocol.  The
// inherited RationalElement conformance must be spelled out: a conformance
// to a derived protocol does not imply the inherited one for generic types.
extension Int2X: @retroactive RationalElement {}
extension Int2X: @retroactive FixedWidthRationalElement {}

// `**` is declared in Exponentiation.swift, by this module.  Do not import
// BigNumOperators or ComplexOperators alongside PONS: their duplicate
// operator declarations would make every `**` use site ambiguous.

// placeholder
public class PONS {}
//
