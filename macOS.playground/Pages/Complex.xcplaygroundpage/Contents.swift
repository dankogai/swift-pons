/*:
 [Previous: BigNum](@previous)

 # Complex -- over any FloatingPoint

 `.i` on any real makes it imaginary; any `FloatingPoint` can be the
 element, and elements that know their math (`RMath`) bring `Complex`
 the math functions at their own precision.
 */
import PONS
//: ## Complex&lt;Double&gt;
let z = 3.0 + 4.0.i
z.abs                       // 5: |3+4i|
z.arg                       // atan2(4, 3)
z.conj                      // 3-4i
z * z.conj                  // 25+0i
Complex.sqrt(-1.0)          // i, at last
Complex.log(-1.0)           // πi
1.0.i ** 0.5                // exp(iπ/4) via pow
//: ## Integer exponents multiply -- exactly, in O(log n) steps
1.0.i ** 2                  // exactly -1+0i; pow's exp-log round trip would leave crumbs
(3.0 + 4.0.i) ** -1         // exactly 0.12 - 0.16i
//: ## Complex&lt;BigFloat&gt;, Complex&lt;BigRat&gt;
let pi = BigFloat.PI(precision: 128)
Complex.exp(pi.i)           // e^(iπ): -1, plus an imaginary speck ~2^-128
Complex.sqrt(Complex(BigFloat(2)), precision: 256)  // ~77 digits
let q = Complex(BigRat(1, 2), BigRat(1, 2))         // (1+i)/2, exactly
q ** 2                      // exactly i/2
q ** -2                     // exactly -2i
//: ## GaussianInt -- complex integers, deliberately separate
let g = GaussianInt(3, 4)
g * g.conj                  // 25: the norm, as a Gaussian integer
GaussianInt(BigInt(1) << 64, 1) * GaussianInt(BigInt(1) << 64, -1)
//:
//: [Next: Interval](@next)
