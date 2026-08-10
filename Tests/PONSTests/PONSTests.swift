import Testing
@testable import PONS

@Suite struct ComplexBigNumTests {
    @Test func sqrtOfComplexBigRat() {
        let z = BigRat(42) + BigRat(42).i
        let r = Complex.sqrt(z)
        #expect((r * r - z).abs < BigRat(sign:.plus, exponent:-100, significand:1))
    }
    @Test func sqrtOfComplexBigFloat() {
        let z = BigFloat(42) + BigFloat(42).i
        let r = Complex.sqrt(z)
        #expect((r * r - z).abs < BigFloat(sign:.plus, exponent:-100, significand:1))
    }
}
