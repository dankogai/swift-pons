/*:
 [Previous: Int2X](@previous)

 # Generic Programming -- the point of it all

 PONS began as a demonstration that one algorithm can serve every
 numeric type.  Swift's standard protocols now carry that weight, and
 every PONS type slots into them.
 */
import PONS
//: ## One fib, every integer
func fib<T:BinaryInteger>(_ n:T)->T {
    return n < 2 ? n: (2...Int(n)).reduce((T(0), T(1))){
        (p, _) in (p.1, p.0 + p.1)
    }.1
}
let F11  = fib(11 as Int8)
let F24  = fib(24 as UInt16)
let F92  = fib(92 as Int64)
let F184 = fib(184 as Int128)   // Int2X
let F666 = fib(666 as BigInt)   // BigNum
//: ## One Newton's method, every floating point
//: `FloatingPoint` is all it needs, so `Double`, `BigRat` and
//: `BigFloat` all qualify -- and with exact rational arithmetic the
//: convergence is textbook: the error squares away each round.
func newtonSqrt<T:FloatingPoint>(_ x:T, iterations n:Int = 8)->T {
    var r = x
    for _ in 0..<n { r = (r + x/r) / 2 }
    return r
}
newtonSqrt(2.0)
newtonSqrt(BigFloat(2))
let exact = newtonSqrt(BigRat(2))       // an exact rational: every digit auditable
exact - BigRat.sqrt(BigRat(2))          // agrees to well past 128 bits
//: ## One `**`, every power
2 ** 10                     // Int, exact
BigInt(2) ** 256            // BigInt, exact
2.0 ** 0.5                  // Double, via pow
BigRat(1, 2) ** 3           // BigRat, exact
1.0.i ** 2                  // Complex, exact
BigFloat(1) ± BigFloat(2) ** -10    // and it composes: an Interval<BigFloat>
/*:
 The protocols do the work; the types just show up.  That was the thesis
 in the Swift 2 days, and the standard library has since made it the law
 of the land.
 */
