/*:
 [Previous: Synopsis](@previous)

 # BigNum -- arbitrary precision

 `BigInt` grows as needed, `BigRat` is exact, and `BigFloat` computes
 to however many bits you ask for.
 */
import PONS
//: ## BigInt -- when 64 bits are not enough
let googol = BigInt(10) ** 100
let m127   = BigInt(1) << 127 - 1   // 2^127 - 1, the 12th Mersenne prime
m127.isPrime                        // Bool?: probably prime (nil would mean "don't know")
(m127 + 2).isPrime
//: ## BigRat -- exact where binary floating point is not
0.1 + 0.2 == 0.3                                    // the classic disappointment
BigRat(1, 10) + BigRat(2, 10) == BigRat(3, 10)      // exact, so true
let third = BigInt(1).over(3)
third + third + third == 1
third.toString()                    // "(1/3)"
//: `*` is exact on `BigRat`; `**` and the math functions round to
//: `precision` bits -- know which one you are asking for.
BigRat(1, 3) * BigRat(1, 3)         // exactly 1/9
BigRat(1, 3) ** 2                   // 1/9 rounded to 128 bits: NOT the same thing
BigRat(1, 2) ** 3                   // exact after all: the denominator is a power of two
//: ## BigFloat -- precision on demand
BigFloat.sqrt(BigFloat(2))                  // 128 bits by default
BigFloat.sqrt(BigFloat(2), precision: 512)  // ~154 decimal digits
BigFloat.PI(precision: 256)
BigFloat.exp(BigFloat(1), precision: 256)   // e, to 256 bits
//: The math functions dispatch generically, so the same spelling works
//: for every `Real` -- `Double` just ignores the precision it cannot use.
Double.exp(1.0)
Double.exp(1.0, precision: 1024, debug: false)  // same 53-bit answer
//:
//: [Next: Complex](@next)
