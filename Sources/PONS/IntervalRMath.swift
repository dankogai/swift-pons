//
//  IntervalRMath.swift -- teach Complex that Interval is an RMath, so
//  that `Complex<Interval<BigRat>>` and friends work: complex arithmetic
//  whose real and imaginary parts carry guaranteed brackets.
//
//  swift-interval supplies nearly the whole surface already -- Interval
//  is a FloatingPoint, and IntervalMath has every function down to
//  atan2(y:x:) -- so this file only bridges the spellings swift-interval
//  inherited from swift-bignum (root(x,3), expMinusOne, log(onePlus:)),
//  forwards the RMath-specific members to the element, and accepts the
//  precision:debug: forms.  Interval math always runs at the element's
//  own precision, so the precision argument is accepted and ignored --
//  pick the element's precision to pick the interval's.
//
import Complex
import Interval

extension Interval: @retroactive RMath where F: RMath {
    public init(_ d: Double) { self.init(F(d)) }
    public func toDouble()->Double { return self.mid.toDouble() }
    public static var precision:Int { return F.precision }
    // the names swift-interval spells differently
    public static func cbrt (_ x:Self)->Self { return root(x, 3) }
    public static func expm1(_ x:Self)->Self { return expMinusOne(x) }
    public static func log1p(_ x:Self)->Self { return log(onePlus:x) }
    // precision:debug: forms, accepted and ignored
    public static func acos (_ x:Self, precision:Int, debug:Bool)->Self { return acos (x) }
    public static func acosh(_ x:Self, precision:Int, debug:Bool)->Self { return acosh(x) }
    public static func asin (_ x:Self, precision:Int, debug:Bool)->Self { return asin (x) }
    public static func asinh(_ x:Self, precision:Int, debug:Bool)->Self { return asinh(x) }
    public static func atan (_ x:Self, precision:Int, debug:Bool)->Self { return atan (x) }
    public static func atanh(_ x:Self, precision:Int, debug:Bool)->Self { return atanh(x) }
    public static func cbrt (_ x:Self, precision:Int, debug:Bool)->Self { return cbrt (x) }
    public static func cos  (_ x:Self, precision:Int, debug:Bool)->Self { return cos  (x) }
    public static func cosh (_ x:Self, precision:Int, debug:Bool)->Self { return cosh (x) }
    public static func exp  (_ x:Self, precision:Int, debug:Bool)->Self { return exp  (x) }
    public static func exp2 (_ x:Self, precision:Int, debug:Bool)->Self { return exp2 (x) }
    public static func expm1(_ x:Self, precision:Int, debug:Bool)->Self { return expm1(x) }
    public static func log  (_ x:Self, precision:Int, debug:Bool)->Self { return log  (x) }
    public static func log2 (_ x:Self, precision:Int, debug:Bool)->Self { return log2 (x) }
    public static func log10(_ x:Self, precision:Int, debug:Bool)->Self { return log10(x) }
    public static func log1p(_ x:Self, precision:Int, debug:Bool)->Self { return log1p(x) }
    public static func sin  (_ x:Self, precision:Int, debug:Bool)->Self { return sin  (x) }
    public static func sinh (_ x:Self, precision:Int, debug:Bool)->Self { return sinh (x) }
    public static func sqrt (_ x:Self, precision:Int, debug:Bool)->Self { return sqrt (x) }
    public static func tan  (_ x:Self, precision:Int, debug:Bool)->Self { return tan  (x) }
    public static func tanh (_ x:Self, precision:Int, debug:Bool)->Self { return tanh (x) }
    public static func atan2(y:Self, x:Self, precision:Int, debug:Bool)->Self { return atan2(y:y, x:x) }
    public static func hypot(_ x:Self, _ y:Self, precision:Int, debug:Bool)->Self { return hypot(x, y) }
    public static func pow  (_ x:Self, _ y:Self, precision:Int, debug:Bool)->Self { return pow  (x, y) }
}
