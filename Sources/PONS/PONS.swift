// imported and re-exported
//
// cf. https://github.com/apple/swift/blob/master/docs/Modules.rst#modules-can-re-export-other-modules

// import everything
@_exported import BigNum
@_exported import Complex
// import just a protocol
@_exported import protocol FloatingPointMath.FloatingPointMath

#if os(Linux)
import Glibc
#else
import Darwin
#endif

extension FloatingPointMath {
    #if os(Linux)
    public static func erf   (_ x:Self)->Self { return Self(Glibc.erf  (x.asDouble)) }
    public static func erfc  (_ x:Self)->Self { return Self(Glibc.erfc (x.asDouble)) }
    public static func lgamma(_ x:Self)->Self { return Self(Glibc.lgamma(x.asDouble)) }
    public static func tgamma(_ x:Self)->Self { return Self(Glibc.tgamma(x.asDouble)) }
    #else
    public static func erf   (_ x:Self)->Self { return Self(Darwin.erf  (x.asDouble)) }
    public static func erfc  (_ x:Self)->Self { return Self(Darwin.erfc (x.asDouble)) }
    public static func lgamma(_ x:Self)->Self { return Self(Darwin.lgamma(x.asDouble)) }
    public static func tgamma(_ x:Self)->Self { return Self(Darwin.tgamma(x.asDouble)) }
    #endif
}

extension Double {
    #if os(Linux)
    public static func erf  (_ x:Double)->Double { return Glibc.erf(x) }
    public static func erfc (_ x:Double)->Double { return Glibc.erfc(x) }
    public static func lgamma(_ x:Double)->Double { return Glibc.lgamma(x) }
    public static func tgamma(_ x:Double)->Double { return Glibc.tgamma(x) }
    #else
    public static func erf  (_ x:Double)->Double { return Darwin.erf(x) }
    public static func erfc (_ x:Double)->Double { return Darwin.erfc(x) }
    public static func lgamma(_ x:Double)->Double { return Darwin.lgamma(x) }
    public static func tgamma(_ x:Double)->Double { return Darwin.tgamma(x) }
    #endif
}

// placeholder
extension BigNum {
    // public static var constants = [String:(value:Any,precision:Int)]()
    public static func factorial(_ n:Int)->BigInt {
        return n < 1 ? BigInt(1) : (1 ... n).map { BigInt($0) }.reduce(BigInt(1), *)
    }
    public static func binominalCoefficient(_ x:BigInt, _ y:BigInt)->BigInt {
        var (n, k) = x < y ? (y, x) : (x, y)
        if n < 2*k  { k = n - k }
        if k == 0   { return 1 }
        let u = ((n-k+1)...n).reduce(1, *)
        let v = (1...k).reduce(1, *)
        return u / v
    }
    private static var bernoulliNumbers = [BigRat(1), -BigRat(1, 2)]
    public static func bernoulliNumber(_ n : Int)->BigRat {
        if n < bernoulliNumbers.count { return bernoulliNumbers[n] }
        var b = BigRat(0)
        if n & 1 == 0 {
            for k in 0...n-1 {
                b += binominalCoefficient(BigInt(n+1), BigInt(k)) * bernoulliNumber(k)
            }
            b /= -BigRat(n + 1)
        }
        bernoulliNumbers.append(b)
        return b
    }
}


extension RationalType {
    /// Γx
    public static func tgamma(_ x:Self, precision px:Int = 64)->Self   {
        return exp(lgamma(x, precision:px*2), precision:px)
    }
    //
    // cf. http://algolist.manual.ru/maths/count_fast/gamma_function.php
    //
    /// lnΓx
    public static func lgamma(_ x:Self, precision px:Int = 64, debug:Bool = false)->Self   {
        if x.isNaN      { return nan }
        if x.isZero     { return 1/x }
        if x.isInfinite { return +infinity }
        if x == 1       { return 0 }
        //        let (ix, fx) = x.asMixed
        //        if fx == 0 {
        //            return log(Self(BigNum.factorial(Int(ix) - 1)), precision:px)
        //        }
        let pi = PI(precision:px*2)
        if x.sign == .minus {
            // real part of log(gamma(z))
            let lgmx  = lgamma(-x, precision:px*2, debug:debug)
            if debug { print("lgamma(\(-x)) =", lgmx) }
            let sinpi = sin(pi * -x, precision:px*2)
            let r = log(pi, precision:px*2) - log(-x, precision:px*2)
                - lgmx
                - log(sinpi.magnitude, precision:px*2)
            return px < 0 ? r : r.truncated(width: px)
            
        }
        // print("Double.lgamma(\(x.asDouble)) =", Double.lgamma(x.asDouble))
        let bias = Self(16)
        var (u, v) = (x, Self(1))
        while u < bias {
            v *= u; u += 1; v.truncate(width:px*2)
        }
        if debug { print("(x, u, v) = ", x, u, v) }
        var r = (u - 0.5) * log(u, precision:px*2)
        r += -u
        r += +log(2*pi, precision:px*2)/2
        r += -log(v.magnitude, precision:px*2)
        if debug { print(0, r.asDouble) }
        let epsilon = Self(BigInt(1).over(1 << px.magnitude * 2))
        let x2 = u * u
        var d = u
        for i in 1...px.magnitude {
            if i & 1 == 1 { continue }
            let n = Self(BigNum.bernoulliNumber(Int(i)) / BigRat(i * (i-1)))
            if debug { print(i, n, d.asDouble) }
            let t = n / d
            r += t
            r.truncate(width:px*2)
            if t.magnitude < epsilon { break }
            d *= x2
            d.truncate(width:px*2)
        }
        return px < 0 ? r : r.truncated(width: px)
    }
}
