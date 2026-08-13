/*:
 # PONS -- Protocol-Oriented Number System

 One import gets you the whole menagerie: arbitrary-precision integers,
 rationals, and floats; complex numbers over any of them; intervals;
 double-width fixed integers; and the operators to match.
 */
import PONS // That's all it takes to get…

let bi = BigInt(1) << 1024 - 1              // BigInt
var bq = BigInt(1).over(BigInt(2))          // BigRat, exactly 1/2
bq = BigRat.sqrt(bq)                        // and its math functions
let fq = Int1024(1).over(7)                 // Rational<Int1024>, exactly 1/7
let bf = BigFloat(bq)                       // BigFloat
BigFloat.acos(bf)                           // its math functions...
BigFloat.acos(bf, precision: 256)           // ...to any precision you ask
let cd = Complex.sqrt(-1.0)                 // Complex<Double>
let pi = BigFloat.PI(precision: 128)
let cf = Complex.exp(pi.i)                  // Complex<BigFloat>: e^(πi) == -1
BigInt(2) ** 256                            // exponentiation, exact
1.0.i ** 2                                  // exactly -1 + 0i: no pow() round trip
BigFloat(1) ± BigFloat(2) ** -10            // Interval<BigFloat>
Interval.sqrt(2.0 ± 0.001)                  // brackets sqrt(2), guaranteed
//: Each page ahead dives into one corner of the system.
//:
//: [Next: BigNum](@next)
