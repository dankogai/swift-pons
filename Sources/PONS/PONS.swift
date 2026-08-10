

// imported and re-exported
//
// cf. https://github.com/apple/swift/blob/master/docs/Modules.rst#modules-can-re-export-other-modules

// import everything
@_exported import BigNum
@_exported import Complex
// @_exported import Interval
// import just a protocol

extension BigRat:   @retroactive RMath {}
extension BigFloat: @retroactive RMath {}

// `**` is declared in Exponentiation.swift, by this module.  Do not import
// BigNumOperators or ComplexOperators alongside PONS: their duplicate
// operator declarations would make every `**` use site ambiguous.

// placeholder
public class PONS {}
//
