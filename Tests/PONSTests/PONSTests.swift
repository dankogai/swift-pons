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

@Suite struct ExponentiationTests {
    @Test func integerPower() {
        #expect(2 ** 10 == 1024)
        #expect(BigInt(2) ** 256 == BigInt(1) << 256)
    }
    @Test func realPower() {
        #expect(abs(2.0 ** 0.5 - 2.0.squareRoot()) < 1e-15)
        #expect(BigRat(1, 2) ** 3 == BigRat(1, 8))
        #expect((BigFloat(2) ** BigFloat(0.5) - BigFloat.sqrt(BigFloat(2))).magnitude
                < BigFloat(sign:.plus, exponent:-100, significand:1))
    }
    @Test func complexPower() {
        let w = 1.0.i ** 0.5    // i ** 0.5 == exp(i * pi / 4)
        #expect((w * w - 1.0.i).abs < 1e-15)
    }
}
