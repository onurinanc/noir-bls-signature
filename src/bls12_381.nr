use dep::std::println;
use dep::bigint::prime_field::PrimeField as Fp;

mod fp2;
mod fp6;
mod fp12;
mod g2;
mod pairing;
mod swcurve;
mod constants;
mod signature;

use fp2::Fp2;
use fp6::Fp6;
use fp12::Fp12;
use g2::G2Point;
use g2::G2Curve;
use swcurve::Point;
use swcurve::Curve;

// G2 curve for BLS12_381
struct BLS12_381G2 {
    curve: G2Curve,
}

// G1 curve for BLS12_381
struct BLS12_381 {
    curve: Curve,
}

// Construct G1 curve for BLS12_381
fn bls12_381() -> BLS12_381 {
    BLS12_381 {
        curve: Curve::new(
            Fp::zero(),
            Fp::from_u56(4),
            Point::from_affine( 
                Fp::from_bytes(
                    [
                        0xbb, 0xc6, 0x22, 0xdb, 0x0a, 0xf0, 0x3a, 0xfb,
                        0xef, 0x1a, 0x7a, 0xf9, 0x3f, 0xe8, 0x55, 0x6c,
                        0x58, 0xac, 0x1b, 0x17, 0x3f, 0x3a, 0x4e, 0xa1,
                        0x05, 0xb9, 0x74, 0x97, 0x4f, 0x8c, 0x68, 0xc3,
                        0x0f, 0xac, 0xa9, 0x4f, 0x8c, 0x63, 0x95, 0x26,
                        0x94, 0xd7, 0x97, 0x31, 0xa7, 0xd3, 0xf1, 0x17
                    ]
                ),
                Fp::from_bytes(
                    [
                        0xe1, 0xe7, 0xc5, 0x46, 0x29, 0x23, 0xaa, 0x0c,
                        0xe4, 0x8a, 0x88, 0xa2, 0x44, 0xc7, 0x3c, 0xd0,
                        0xed, 0xb3, 0x04, 0x2c, 0xcb, 0x18, 0xdb, 0x00,
                        0xf6, 0x0a, 0xd0, 0xd5, 0x95, 0xe0, 0xf5, 0xfc,
                        0xe4, 0x8a, 0x1d, 0x74, 0xed, 0x30, 0x9e, 0xa0,
                        0xf1, 0xa0, 0xaa, 0xe3, 0x81, 0xf4, 0xb3, 0x08
                    ]
                ),
            ),
        ),
    }
}

// Construct G2 curve for BLS12_381
fn bls12_381_g2() -> BLS12_381G2 {
    // Construct a, b, and gen for G2 Curve
    // G2_A, G2_B_ G2_GENERATOR_X, and G2_GENERATOR_Y

    let G2_A = Fp2::zero();
    let G2_B: Fp2 = Fp2::new(
        Fp::from_u56(4),
        Fp::from_u56(4)
    );

    // Part X of the generator
    // 352701069587466618187139116011060144890029952792775240219908644239793785735715026873347600343865175952761926303160
    // 3059144344244213709971259814753781636986470325476647558659373206291635324768958432433509563104347017837885763365758

    let G2_GENERATOR_X: Fp2 = Fp2::new(
        Fp::from_bytes(
                    [
                        0xb8, 0xbd, 0x21, 0xc1, 0xc8, 0x56, 0x80, 0xd4,
                        0xef, 0xbb, 0x05, 0xa8, 0x26, 0x03, 0xac, 0x0b,
                        0x77, 0xd1, 0xe3, 0x7a, 0x64, 0x0b, 0x51, 0xb4,
                        0x02, 0x3b, 0x40, 0xfa, 0xd4, 0x7a, 0xe4, 0xc6,
                        0x51, 0x10, 0xc5, 0x2d, 0x27, 0x05, 0x08, 0x26,
                        0x91, 0x0a, 0x8f, 0xf0, 0xb2, 0xa2, 0x4a, 0x02
                    ]
                ),
        Fp::from_bytes(
                    [
                        0x7e, 0x2b, 0x04, 0x5d, 0x05, 0x7d, 0xac, 0xe5,
                        0x57, 0x5d, 0x94, 0x13, 0x12, 0xf1, 0x4c, 0x33,
                        0x49, 0x50, 0x7f, 0xdc, 0xbb, 0x61, 0xda, 0xb5,
                        0x1a, 0xb6, 0x20, 0x99, 0xd0, 0xd0, 0x6b, 0x59,
                        0x65, 0x4f, 0x27, 0x88, 0xa0, 0xd3, 0xac, 0x7d,
                        0x60, 0x9f, 0x71, 0x52, 0x60, 0x2b, 0xe0, 0x13
                    ]
                )
    );

    // Part Y of the generator
    // 1985150602287291935568054521177171638300868978215655730859378665066344726373823718423869104263333984641494340347905
    // 927553665492332455747201965776037880757740193453592970025027978793976877002675564980949289727957565575433344219582

    let G2_GENERATOR_Y: Fp2 = Fp2::new(
        Fp::from_bytes(
                    [
                        0x01, 0x28, 0xb8, 0x08, 0x86, 0x54, 0x93, 0xe1,
                        0x89, 0xa2, 0xac, 0x3b, 0xcc, 0xc9, 0x3a, 0x92,
                        0x2c, 0xd1, 0x60, 0x51, 0x69, 0x9a, 0x42, 0x6d,
                        0xa7, 0xd3, 0xbd, 0x8c, 0xaa, 0x9b, 0xfd, 0xad,
                        0x1a, 0x35, 0x2e, 0xda, 0xc6, 0xcd, 0xc9, 0x8c,
                        0x11, 0x6e, 0x7d, 0x72, 0x27, 0xd5, 0xe5, 0x0c,
                    ]
                ),
        Fp::from_bytes(
                    [
                        0xbe, 0x79, 0x5f, 0xf0, 0x5f, 0x07, 0xa9, 0xaa,
                        0xa1, 0x1d, 0xec, 0x5c, 0x27, 0x0d, 0x37, 0x3f,
                        0xab, 0x99, 0x2e, 0x57, 0xab, 0x92, 0x74, 0x26,
                        0xaf, 0x63, 0xa7, 0x85, 0x7e, 0x28, 0x3e, 0xcb,
                        0x99, 0x8b, 0xc2, 0x2b, 0xb0, 0xd2, 0xac, 0x32,
                        0xcc, 0x34, 0xa7, 0x2e, 0xa0, 0xc4, 0x06, 0x06
                    ]
                )
    );

    BLS12_381G2 {
        curve: G2Curve::new(
            Fp2::zero(),
            G2_B,
            G2Point::from_affine(
                G2_GENERATOR_X,
                G2_GENERATOR_Y,
            )
        )
    }
}

// O + O = O
#[test]
fn test_bls12_381_add1() {
    let BLS12_381 { curve } = bls12_381();

    let p = curve.add(Point::zero(), Point::zero());
    assert(p.is_zero()); 
}

// O + G = G
#[test]
fn test_bls12_381_add2() {
    let BLS12_381 { curve } = bls12_381();

    let p = curve.add(curve.gen, Point::zero());
    assert(p.eq(curve.gen));
}

// (2*G + G) + G = 4*G
#[test]
fn test_bls12_381_add3() {
    let BLS12_381 { curve } = bls12_381();

    let p = curve.add(curve.double(curve.gen), curve.gen);
    let q = curve.add(curve.double(curve.gen), curve.double(curve.gen));
    let p_1 = curve.add(p, curve.gen);
    assert(p_1.eq(q));
}

// 2*G + G = 3*G
#[test]
fn test_bls12_381_add4() {
    let BLS12_381 { curve } = bls12_381();

    let p1 = curve.add(curve.double(curve.gen), curve.gen);
    // p2 is the little endian representation of G * 3
    let p2 = Point::from_affine(
        Fp::from_bytes([
            0x24, 0x52, 0x4e, 0x02, 0xc9, 0xc0, 0xd2, 0x96,
            0x9b, 0x17, 0xa2, 0x2c, 0x0b, 0x7a, 0x74, 0x81,
            0xf9, 0x3f, 0x5b, 0x33, 0x51, 0x0a, 0x78, 0xf3,
            0xf1, 0xa5, 0xe9, 0x9b, 0x1f, 0xd6, 0x12, 0xb1,
            0x97, 0x96, 0xa9, 0xec, 0x2d, 0x21, 0x65, 0x17,
            0x13, 0xf0, 0xd1, 0xf9, 0x08, 0xe3, 0xec, 0x09
        ]),
        Fp::from_bytes([
            0xd1, 0x30, 0xae, 0x90, 0x05, 0x3b, 0x47, 0xa3,
            0x5c, 0xf4, 0x4a, 0x63, 0x6c, 0x25, 0x45, 0xe7,
            0xe6, 0x3b, 0xd4, 0x0f, 0x31, 0x27, 0x9c, 0x9d,
            0x7f, 0x09, 0xc3, 0xab, 0xdd, 0x0c, 0x9a, 0xa6,
            0x0c, 0xf8, 0xc5, 0x89, 0x33, 0x62, 0x84, 0x8a,
            0x9f, 0xb0, 0xf5, 0xa6, 0xd3, 0x80, 0x2b, 0x03
        ]),
    );
    
    assert(p1.eq(p2));
}

// 3*G = 3*G
#[test]
fn test_bls12_381_mul1() {
    let BLS12_381 { curve } = bls12_381();

    let p1 = curve.mul_Field(3, curve.gen);

    // p2 is the little endian representation of G * 3
    let p2 = Point::from_affine(
        Fp::from_bytes([
            0x24, 0x52, 0x4e, 0x02, 0xc9, 0xc0, 0xd2, 0x96,
            0x9b, 0x17, 0xa2, 0x2c, 0x0b, 0x7a, 0x74, 0x81,
            0xf9, 0x3f, 0x5b, 0x33, 0x51, 0x0a, 0x78, 0xf3,
            0xf1, 0xa5, 0xe9, 0x9b, 0x1f, 0xd6, 0x12, 0xb1,
            0x97, 0x96, 0xa9, 0xec, 0x2d, 0x21, 0x65, 0x17,
            0x13, 0xf0, 0xd1, 0xf9, 0x08, 0xe3, 0xec, 0x09
        ]),
        Fp::from_bytes([
            0xd1, 0x30, 0xae, 0x90, 0x05, 0x3b, 0x47, 0xa3,
            0x5c, 0xf4, 0x4a, 0x63, 0x6c, 0x25, 0x45, 0xe7,
            0xe6, 0x3b, 0xd4, 0x0f, 0x31, 0x27, 0x9c, 0x9d,
            0x7f, 0x09, 0xc3, 0xab, 0xdd, 0x0c, 0x9a, 0xa6,
            0x0c, 0xf8, 0xc5, 0x89, 0x33, 0x62, 0x84, 0x8a,
            0x9f, 0xb0, 0xf5, 0xa6, 0xd3, 0x80, 0x2b, 0x03
        ]),
    );
    
    assert(p1.eq(p2));
}

// 3*G
#[test]
fn test_bls12_381_mul_Field1() {
    let BLS12_381 { curve } = bls12_381();

    let x: Field = 3;
    let p1 = curve.mul_Field(x, curve.gen);

    // p2 is the little endian representation of G * 3
    let p2 = Point::from_affine(
        Fp::from_bytes([
            0x24, 0x52, 0x4e, 0x02, 0xc9, 0xc0, 0xd2, 0x96,
            0x9b, 0x17, 0xa2, 0x2c, 0x0b, 0x7a, 0x74, 0x81,
            0xf9, 0x3f, 0x5b, 0x33, 0x51, 0x0a, 0x78, 0xf3,
            0xf1, 0xa5, 0xe9, 0x9b, 0x1f, 0xd6, 0x12, 0xb1,
            0x97, 0x96, 0xa9, 0xec, 0x2d, 0x21, 0x65, 0x17,
            0x13, 0xf0, 0xd1, 0xf9, 0x08, 0xe3, 0xec, 0x09
        ]),
        Fp::from_bytes([
            0xd1, 0x30, 0xae, 0x90, 0x05, 0x3b, 0x47, 0xa3,
            0x5c, 0xf4, 0x4a, 0x63, 0x6c, 0x25, 0x45, 0xe7,
            0xe6, 0x3b, 0xd4, 0x0f, 0x31, 0x27, 0x9c, 0x9d,
            0x7f, 0x09, 0xc3, 0xab, 0xdd, 0x0c, 0x9a, 0xa6,
            0x0c, 0xf8, 0xc5, 0x89, 0x33, 0x62, 0x84, 0x8a,
            0x9f, 0xb0, 0xf5, 0xa6, 0xd3, 0x80, 0x2b, 0x03
        ]),
    );
    
    assert(p1.eq(p2));
}

// a + (b + c) == a + (c + b) == b + (c + a)
#[test]
fn test_fp2_add() {
    let a: Fp2 = Fp2::new(Fp::from_u56(1), Fp::from_u56(2));
    let b: Fp2 = Fp2::new(Fp::from_u56(3), Fp::from_u56(5));
    let c: Fp2 = Fp2::new(Fp::from_u56(8), Fp::from_u56(11));
    
    let t0 = a.add(b.add(c));
    let t1 = a.add(c.add(b));
    let t2 = b.add(c.add(a));

    assert(t0.c0.eq(t1.c0));
    assert(t0.c0.eq(t2.c0));
    assert(t1.c0.eq(t2.c0));
    assert(t0.c1.eq(t1.c1));
    assert(t0.c1.eq(t2.c1));
    assert(t1.c1.eq(t2.c1));
}

// a * (b * c) == a * (c * b) = b * (c * a)
#[test]
fn test_fp2_mul() {
    let a: Fp2 = Fp2::new(Fp::from_u56(1), Fp::from_u56(2));
    let b: Fp2 = Fp2::new(Fp::from_u56(3), Fp::from_u56(5));
    let c: Fp2 = Fp2::new(Fp::from_u56(8), Fp::from_u56(11));

    let t0 = a.mul(b.mul(c));
    let t1 = a.mul(c.mul(b));
    let t2 = b.mul(c.mul(a));

    assert(t0.c0.eq(t1.c0));
    assert(t0.c0.eq(t2.c0));
    assert(t1.c0.eq(t2.c0));
    assert(t0.c1.eq(t1.c1));
    assert(t0.c1.eq(t2.c1));
    assert(t1.c1.eq(t2.c1));
}

// a + a == 2*a
#[test]
fn test_fp2_double() {
    let a: Fp2 = Fp2::new(Fp::from_u56(8), Fp::from_u56(11));
    let b = a.add(a);
    let c = a.double();

    assert(b.c0.eq(c.c0));
    assert(b.c1.eq(c.c1));
}

// a * a == a^2
#[test]
fn test_fp2_square() {
    let a: Fp2 = Fp2::new(Fp::from_u56(8), Fp::from_u56(11));
    let b = a.mul(a);
    let c = a.square();

    assert(b.c0.eq(c.c0));
    assert(b.c1.eq(c.c1));
}

// (2+2u) * (9+u) = (16+20u)
#[test]
fn test_fp2_mul_by_nonresidue(){
    let a: Fp2 = Fp2::new(Fp::from_u56(1), Fp::from_u56(1));
    let a = a.mul_by_nonresidue();
    Fp::println(a.c0);
    Fp::println(a.c1);
}

// a*a^-1 == O
#[test]
fn test_fp2_invert() {
    let a: Fp2 = Fp2::new(Fp::from_u56(1), Fp::from_u56(2));
    let b = a.invert();
    let c = a.mul(b);
    assert(c.c0.eq(Fp::one()));
    Fp::println(c.c0);
    Fp::println(c.c1);
}

// a*a^-1 == O
#[test]
fn test_fp2_invert2() {
    let a: Fp2 = Fp2::new(Fp::from_u56(2347), Fp::from_u56(9812));
    let b = a.invert();
    let c = a.mul(b);
    //assert(c.c0.eq(Fp::one()));
    //assert(c.c1.eq(Fp::zero()));
    assert(c.eq(Fp2::one()));
    Fp::println(c.c0);
    Fp::println(c.c1);
}

// a + (b + c) == a + (c + b) == b + (c + a)
#[test]
fn test_fp6_add() {
    let a: Fp2 = Fp2::new(Fp::from_u56(1), Fp::from_u56(2));
    let b: Fp2 = Fp2::new(Fp::from_u56(3), Fp::from_u56(5));
    let c: Fp2 = Fp2::new(Fp::from_u56(8), Fp::from_u56(11));
    
    let x1: Fp6 = Fp6::new(a, b, c);
    let x2: Fp6 = Fp6::new(a, a, b);
    let x3: Fp6 = Fp6::new(b, c, c);

    let t0 = x1.add(x2.add(x3));
    let t1 = x1.add(x3.add(x2));
    let t2 = x2.add(x3.add(x1));

    assert(t0.c0.eq(t1.c0));
    assert(t0.c0.eq(t2.c0));
    assert(t1.c0.eq(t2.c0));
    assert(t0.c1.eq(t1.c1));
    assert(t0.c1.eq(t2.c1));
    assert(t1.c1.eq(t2.c1));
    assert(t0.c2.eq(t1.c2));
    assert(t0.c2.eq(t2.c2));
    assert(t1.c2.eq(t2.c2));
}

// a * (b * c) == a * (c * b) = b * (c * a)
#[test]
fn test_fp6_mul() {
    let a: Fp2 = Fp2::new(Fp::from_u56(1), Fp::from_u56(2));
    let b: Fp2 = Fp2::new(Fp::from_u56(3), Fp::from_u56(5));
    let c: Fp2 = Fp2::new(Fp::from_u56(8), Fp::from_u56(11));
    
    let x1: Fp6 = Fp6::new(a, b, c);
    let x2: Fp6 = Fp6::new(c, b, b);
    let x3: Fp6 = Fp6::new(b, c, c);

    let t0 = x1.mul(x2.mul(x3));
    let t1 = x1.mul(x3.mul(x2));
    let t2 = x2.mul(x3.mul(x1));

    assert(t0.c0.eq(t1.c0));
    assert(t0.c0.eq(t2.c0));
    assert(t1.c0.eq(t2.c0));
    assert(t0.c1.eq(t1.c1));
    assert(t0.c1.eq(t2.c1));
    assert(t1.c1.eq(t2.c1));
    assert(t0.c2.eq(t1.c2));
    assert(t0.c2.eq(t2.c2));
    assert(t1.c2.eq(t2.c2));
}

// a * O = O
#[test]
fn test_fp6_mul2() {
    let a: Fp2 = Fp2::new(Fp::from_u56(1), Fp::from_u56(2));
    let b: Fp2 = Fp2::new(Fp::from_u56(3), Fp::from_u56(5));
    let c: Fp2 = Fp2::new(Fp::from_u56(8), Fp::from_u56(11));
    
    let x1: Fp6 = Fp6::new(a, b, c);
    let x2: Fp6 = Fp6::new(c, b, b);
    let x3: Fp6 = Fp6::new(b, c, c);

    let x = x1.mul(Fp6::one());
    assert(x.eq(x1));
}

// a + a == 2*a
#[test]
fn test_fp6_double() {
    let b: Fp2 = Fp2::new(Fp::from_u56(3), Fp::from_u56(5));
    let c: Fp2 = Fp2::new(Fp::from_u56(8), Fp::from_u56(11));
    let d: Fp2 = Fp2::new(Fp::from_u56(1), Fp::from_u56(2));

    let a: Fp6 = Fp6::new(b, c, d);
    let b = a.add(a);
    let c = a.double();

    assert(b.c0.eq(c.c0));
    assert(b.c1.eq(c.c1));
    assert(b.c2.eq(c.c2));
}

// a * a == a^2
#[test]
fn test_fp6_square() {
    let b: Fp2 = Fp2::new(Fp::from_u56(3), Fp::from_u56(5));
    let c: Fp2 = Fp2::new(Fp::from_u56(8), Fp::from_u56(11));
    let d: Fp2 = Fp2::new(Fp::from_u56(1), Fp::from_u56(2));

    let a: Fp6 = Fp6::new(b, c, d);
    let x = a.mul(a);
    let y = a.square();

    assert(x.c0.eq(y.c0));
    assert(x.c1.eq(y.c1));
    assert(x.c2.eq(y.c2));
}

// a*a^-1 == O
#[test]
fn test_fp6_invert() {
    let x: Fp2 = Fp2::new(Fp::from_u56(3), Fp::from_u56(5));
    let y: Fp2 = Fp2::new(Fp::from_u56(8), Fp::from_u56(11));
    let z: Fp2 = Fp2::new(Fp::from_u56(1), Fp::from_u56(2));

    let a = Fp6::new(x, y, z);
    let b = a.invert_x();
    let c = a.mul(b);

    // assert(c.eq(Fp6::one()));
    Fp::println(c.c0.c0);
    Fp::println(c.c0.c1);
    Fp::println(c.c1.c0);
    Fp::println(c.c1.c1);
    Fp::println(c.c2.c0);
    Fp::println(c.c2.c1);
}

// a + (b + c) == a + (c + b) == b + (c + a)
#[test]
fn test_fp12_add() {
    let a: Fp2 = Fp2::new(Fp::from_u56(1), Fp::from_u56(2));
    let b: Fp2 = Fp2::new(Fp::from_u56(3), Fp::from_u56(5));
    let c: Fp2 = Fp2::new(Fp::from_u56(8), Fp::from_u56(11));
    
    let a1: Fp6 = Fp6::new(a, b, c);
    let a2: Fp6 = Fp6::new(a, a, b);
    let a3: Fp6 = Fp6::new(b, c, c);
    let a4: Fp6 = Fp6::new(c, b, a);

    let x1: Fp12 = Fp12::new(a1, a4);
    let x2: Fp12 = Fp12::new(a3, a2);
    let x3: Fp12 = Fp12::new(a4, a2);

    let t0 = x1.add(x2.add(x3));
    let t1 = x1.add(x3.add(x2));
    let t2 = x2.add(x3.add(x1));

    assert(t0.c0.eq(t1.c0));
    assert(t0.c0.eq(t2.c0));
    assert(t1.c0.eq(t2.c0));
    assert(t0.c1.eq(t1.c1));
    assert(t0.c1.eq(t2.c1));
    assert(t1.c1.eq(t2.c1));
}

// a * (b * c) == a * (c * b) = b * (c * a)
#[test]
fn test_fp12_mul() {
    let a: Fp2 = Fp2::new(Fp::from_u56(1), Fp::from_u56(2));
    let b: Fp2 = Fp2::new(Fp::from_u56(3), Fp::from_u56(5));
    let c: Fp2 = Fp2::new(Fp::from_u56(8), Fp::from_u56(11));
    
    let a1: Fp6 = Fp6::new(a, b, c);
    let a2: Fp6 = Fp6::new(a, a, b);
    let a3: Fp6 = Fp6::new(b, c, c);
    let a4: Fp6 = Fp6::new(c, b, a);

    let x1: Fp12 = Fp12::new(a1, a4);
    let x2: Fp12 = Fp12::new(a3, a2);
    let x3: Fp12 = Fp12::new(a4, a2);

    let t0 = x1.mul(x2.mul(x3));
    let t1 = x1.mul(x3.mul(x2));
    let t2 = x2.mul(x3.mul(x1));

    assert(t0.c0.eq(t1.c0));
    assert(t0.c0.eq(t2.c0));
    assert(t1.c0.eq(t2.c0));
    assert(t0.c1.eq(t1.c1));
    assert(t0.c1.eq(t2.c1));
    assert(t1.c1.eq(t2.c1));
}

// a + a == 2*a
#[test]
fn test_fp12_double() {
    let a: Fp2 = Fp2::new(Fp::from_u56(1), Fp::from_u56(2));
    let b: Fp2 = Fp2::new(Fp::from_u56(3), Fp::from_u56(5));
    let c: Fp2 = Fp2::new(Fp::from_u56(8), Fp::from_u56(11));
    
    let a1: Fp6 = Fp6::new(a, b, c);
    let a2: Fp6 = Fp6::new(a, a, b);
    let a3: Fp6 = Fp6::new(b, c, c);
    let a4: Fp6 = Fp6::new(c, b, a);

    let a: Fp12 = Fp12::new(a1, a4);

    let b = a.add(a);
    let c = a.double();

    assert(b.c0.eq(c.c0));
    assert(b.c1.eq(c.c1));
}

// a * a == a^2
#[test]
fn test_fp12_square() {
    let a: Fp2 = Fp2::new(Fp::from_u56(1), Fp::from_u56(2));
    let b: Fp2 = Fp2::new(Fp::from_u56(3), Fp::from_u56(5));
    let c: Fp2 = Fp2::new(Fp::from_u56(8), Fp::from_u56(11));
    
    let a1: Fp6 = Fp6::new(a, b, c);
    let a2: Fp6 = Fp6::new(a, a, b);
    let a3: Fp6 = Fp6::new(b, c, c);
    let a4: Fp6 = Fp6::new(c, b, a);

    let a: Fp12 = Fp12::new(a1, a4);

    let b = a.mul(a);
    let c = a.square();

    assert(b.c0.eq(c.c0));
    assert(b.c1.eq(c.c1));
}

// a*a^-1 == O
#[test]
fn test_fp12_invert() {
    let a: Fp2 = Fp2::new(Fp::from_u56(1), Fp::from_u56(2));
    let b: Fp2 = Fp2::new(Fp::from_u56(3), Fp::from_u56(5));
    let c: Fp2 = Fp2::new(Fp::from_u56(8), Fp::from_u56(11));
    
    let a1: Fp6 = Fp6::new(a, b, c);
    let a2: Fp6 = Fp6::new(a, a, b);
    let a3: Fp6 = Fp6::new(b, c, a);
    let a4: Fp6 = Fp6::new(c, b, a);

    let a: Fp12 = Fp12::new(a1, a3);
    let d: Fp12 = Fp12::new(a2, a4);

    let b = a.invert();
    let c = a.mul(b);

    assert(c.eq(Fp12::one()));
}

// O + O = O
#[test]
fn test_bls12_381_g2_add1() {
    let BLS12_381G2 { curve } = bls12_381_g2();

    let p = curve.add(G2Point::zero(), G2Point::zero());
    assert(p.is_zero()); 
}

// O + G = G
#[test]
fn test_bls12_381_g2_add2() {
    let BLS12_381G2 { curve } = bls12_381_g2();

    let p = curve.add(curve.gen, G2Point::zero());
    assert(p.eq(curve.gen));
}

// (2*G + G) + G = (2*G + 2*G)
#[test]
fn test_bls12_381_g2_add3() {
    let BLS12_381G2 { curve } = bls12_381_g2();

    let p = curve.add(curve.double(curve.gen), curve.gen);
    let q = curve.add(curve.double(curve.gen), curve.double(curve.gen));
    let p_1 = curve.add(p, curve.gen);
    assert(p_1.eq(q));
}

// Basic invert function for Fp
#[test]
fn test_inversion() {
    let a = Fp::from_u56(8);
    let b = a.invert();
    let c = a.mul(b);
    assert(c.eq(Fp::one()));
}

// for i in 0..2 -> 35 seconds
// for i in 0..8 -> 3 minutes 50 seconds
// for i in 0..10 -> 5 minutes 50 seconds
// for i in 0..12 -> 8 minutes 10 seconds
// for i in 0..64 -> 64 minutes
// 16 GB RAM, Intel Core i5-12450H

//#[test]
//fn test_miller_loop() {
//    let g2: BLS12_381G2 = bls12_381_g2();
//    let g1: BLS12_381 = bls12_381();
//
//    let res = pairing::miller_loop(g2.curve.gen, g1.curve.gen); 
//}


//#[test]
//fn test_fp12_final_exp() {
//    let a: Fp2 = Fp2::new(Fp::from_u56(1), Fp::from_u56(2));
//    let b: Fp2 = Fp2::new(Fp::from_u56(3), Fp::from_u56(5));
//    let c: Fp2 = Fp2::new(Fp::from_u56(8), Fp::from_u56(11));
//    
//    let a1: Fp6 = Fp6::new(a, b, c);
//    let a2: Fp6 = Fp6::new(a, a, b);
//    let a3: Fp6 = Fp6::new(b, c, c);
//    let a4: Fp6 = Fp6::new(c, b, a);
//
//    let x1: Fp12 = Fp12::new(a1, a4);
//    let x2: Fp12 = Fp12::new(a3, a2);
//    let x3: Fp12 = Fp12::new(a4, a2);
//    
//    let res = pairing::final_exponentiation(x1);
//}


// ~7 minutes 15 seconds
// 16 GB RAM, Intel Core i5-12450H

//#[test]
//fn test_final_exponentiation() {
//    let res = pairing::final_exponentiation(Fp12::one());
//    assert(res.eq(Fp12::one()));
//}


// ~72 minutes = ~1.2 h < 1.9 h (circom-pairing compilation time)
// 16 GB RAM, Intel Core i5-12450H

//#[test]
//fn test_pairing_rough() {
//    let g2: BLS12_381G2 = bls12_381_g2();
//    let g1: BLS12_381 = bls12_381();
//
//    let res = pairing::pair(g2.curve.gen, g1.curve.gen);
//}


// test bilinearity: e(P, Q + R) = e(P, Q) * e(P, R)
//#[test]
//fn test_pairing() {
//    let g2: BLS12_381G2 = bls12_381_g2();
//    let g1: BLS12_381 = bls12_381();
//    let g1_double = g1.curve.double(g1.curve.gen);
//
//    let p_add_q = g1.curve.add(g1.curve.gen, g1_double);
//    let lhs = pairing::pair(g2.curve.gen, p_add_q);
//    let rhs_1 = pairing::pair(g2.curve.gen, g1.curve.gen);
//    let rhs_2 = pairing::pair(g2.curve.gen, g1_double);
//    let rhs = rhs_1.mul(rhs_2);
//    assert(lhs.eq(rhs));
//}

// test bls signature verification
// ~ 145 minutes = ~2.4 h < 3.2 h (circom-pairing compilation)
// 16 GB RAM, Intel Core i5-12450H
// Test vectors are generated using: https://github.com/input-output-hk/bls-e2e-testvectors/tree/main

//#[test]
//fn test_verify_bls_signature() {
//    let g2: BLS12_381G2 = bls12_381_g2();
//    let g1: BLS12_381 = bls12_381();
//    
//    let SIGNATURE_X: Fp2 = Fp2::new(
//        Fp::from_bytes(
//                    [
//                        0x29, 0x0b, 0x0e, 0x34, 0x32, 0x50, 0x16, 0x12,
//                        0x27, 0x7a, 0xca, 0x7b, 0x36, 0x15, 0xe1, 0xa5,
//                        0x2d, 0xed, 0x21, 0x22, 0x0c, 0x2a, 0xc7, 0xf3,
//                        0x33, 0x22, 0xea, 0xe2, 0x8d, 0x43, 0x48, 0x7e,
//                        0x34, 0x2d, 0xd5, 0xe7, 0x90, 0xb2, 0x60, 0x53,
//                        0x51, 0x06, 0x6b, 0xd8, 0xc1, 0x2e, 0x26, 0x09
//                    ]
//                ),
//        Fp::from_bytes(
//                    [
//                        0x5d, 0x10, 0x4c, 0x6f, 0xcf, 0x76, 0x6a, 0xa9,
//                        0x78, 0x65, 0x8a, 0xd9, 0x61, 0x9f, 0x7c, 0xd6,
//                        0x10, 0x25, 0xe4, 0x99, 0x27, 0xd3, 0x0a, 0xf7,
//                        0xf9, 0xfd, 0x5d, 0x23, 0xfc, 0x0d, 0xcd, 0x55,
//                        0xab, 0x07, 0x27, 0xbe, 0x81, 0x0d, 0xe1, 0x01,
//                        0xae, 0x63, 0x5a, 0x43, 0xc5, 0xce, 0x8c
//                    ]
//                )
//    );
//
//    let SIGNATURE_Y: Fp2 = Fp2::new(
//        Fp::from_bytes(
//                    [
//                        0x16, 0x91, 0xf0, 0x40, 0x9c, 0x72, 0xea, 0x2c,
//                        0xe7, 0xd2, 0xdb, 0x46, 0x66, 0x24, 0xac, 0x8d,
//                        0x8b, 0x0d, 0xbb, 0x41, 0xb9, 0x45, 0x46, 0x3c,
//                        0x56, 0x03, 0x10, 0x04, 0x3c, 0x72, 0xd1, 0xce,
//                        0x89, 0x4d, 0x49, 0x7d, 0x25, 0xa4, 0x72, 0x66,
//                        0x65, 0x95, 0x26, 0x55, 0x9c, 0xe7, 0x20, 0x14
//                    ]
//                ),
//        Fp::from_bytes(
//                    [
//                        0xde, 0x6f, 0x6b, 0x3f, 0x42, 0x5a, 0x37, 0x1e,
//                        0xc9, 0x37, 0xad, 0x2d, 0x71, 0x07, 0x41, 0x83,
//                        0xc4, 0xd3, 0x0e, 0x22, 0x7e, 0x25, 0x71, 0x9b,
//                        0x6f, 0x4a, 0x95, 0x6e, 0x60, 0x12, 0x74, 0xbf,
//                        0x12, 0xe5, 0x26, 0x16, 0xc4, 0x05, 0x65, 0x71,
//                        0xbe, 0x1f, 0x3f, 0x1e, 0x82, 0x38, 0x0f, 0x02
//                    ]
//                )
//    );
//
//    let SIGNATURE: G2Point = G2Point::from_affine(
//                SIGNATURE_X,
//                SIGNATURE_Y);
//
//    let MESSAGE_HASH_X: Fp2 = Fp2::new(
//        Fp::from_bytes(
//                    [
//                        0x7d, 0x58, 0xbc, 0xa0, 0xa0, 0x70, 0xf9, 0x64,
//                        0xa7, 0x43, 0xa8, 0xd0, 0xfe, 0xb1, 0x5e, 0x23,
//                        0x19, 0x52, 0xa2, 0x2c, 0x4f, 0xf1, 0xc5, 0x0c,
//                        0xf8, 0x2c, 0x9f, 0x93, 0xe5, 0x8a, 0xb9, 0x9a,
//                        0x08, 0xa7, 0x4a, 0x8c, 0x7d, 0x4f, 0xf6, 0x9d,
//                        0x99, 0x39, 0x47, 0x59, 0x72, 0xb6, 0xd9, 0x03
//                    ]
//                ),
//        Fp::from_bytes(
//                    [
//                        0x5a, 0x3e, 0x48, 0xfd, 0xbc, 0xef, 0xc1, 0x2d,
//                        0xe5, 0xe9, 0x41, 0xb1, 0xb4, 0xed, 0x9e, 0x1f,
//                        0xc6, 0xeb, 0x0d, 0x9c, 0xc3, 0xc0, 0x78, 0x45,
//                        0xf2, 0xf1, 0x32, 0x97, 0x4f, 0xd4, 0xc5, 0x8b,
//                        0x8f, 0x27, 0x5a, 0x1f, 0x58, 0x89, 0xe4, 0xf4,
//                        0x09, 0xe8, 0xb3, 0x59, 0x2d, 0x14, 0x1d, 0x16
//                    ]
//                )
//    );
//
//    let MESSAGE_HASH_Y: Fp2 = Fp2::new(
//        Fp::from_bytes(
//                    [
//                        0xa4, 0x4d, 0xe1, 0xba, 0xde, 0x0a, 0xdf, 0x2c,
//                        0x88, 0xd7, 0xe2, 0x94, 0x81, 0x00, 0x4a, 0x5e,
//                        0xdb, 0x86, 0xbb, 0x78, 0xed, 0x25, 0x74, 0x4e,
//                        0xde, 0x43, 0xa6, 0x72, 0x78, 0x84, 0xeb, 0x04,
//                        0x93, 0xe8, 0xa1, 0x41, 0x6d, 0x12, 0xcf, 0xe7,
//                        0x9f, 0x19, 0x0d, 0xbf, 0x21, 0x13, 0x69
//                    ]
//                ),
//        Fp::from_bytes(
//                    [
//                        0x84, 0x84, 0x70, 0xf8, 0x6c, 0xea, 0x4a, 0x36,
//                        0x53, 0x6e, 0x26, 0x39, 0x93, 0x19, 0x67, 0x1a,
//                        0x54, 0xdc, 0xf0, 0x18, 0x0d, 0x3a, 0xf6, 0x2f,
//                        0x10, 0x53, 0x1a, 0x78, 0x33, 0x00, 0xbe, 0xaf,
//                        0x09, 0xce, 0x6f, 0x33, 0xeb, 0xf8, 0xb8, 0xe0,
//                        0x8b, 0x7d, 0xa0, 0xcb, 0x04, 0x5b, 0xbf, 0x18
//                    ]
//                )
//    );
//
//    let MESSAGE_HASH: G2Point = G2Point::from_affine(
//                MESSAGE_HASH_X,
//                MESSAGE_HASH_Y);
//
//    let PUBLIC_KEY: Point = Point::from_affine( 
//        Fp::from_bytes(
//            [
//                0xbb, 0xc6, 0x22, 0xdb, 0x0a, 0xf0, 0x3a, 0xfb,
//                0xef, 0x1a, 0x7a, 0xf9, 0x3f, 0xe8, 0x55, 0x6c,
//                0x58, 0xac, 0x1b, 0x17, 0x3f, 0x3a, 0x4e, 0xa1,
//                0x05, 0xb9, 0x74, 0x97, 0x4f, 0x8c, 0x68, 0xc3,
//                0x0f, 0xac, 0xa9, 0x4f, 0x8c, 0x63, 0x95, 0x26,
//                0x94, 0xd7, 0x97, 0x31, 0xa7, 0xd3, 0xf1, 0x17
//            ]
//        ),
//        Fp::from_bytes(
//            [
//                0xe1, 0xe7, 0xc5, 0x46, 0x29, 0x23, 0xaa, 0x0c,
//                0xe4, 0x8a, 0x88, 0xa2, 0x44, 0xc7, 0x3c, 0xd0,
//                0xed, 0xb3, 0x04, 0x2c, 0xcb, 0x18, 0xdb, 0x00,
//                0xf6, 0x0a, 0xd0, 0xd5, 0x95, 0xe0, 0xf5, 0xfc,
//                0xe4, 0x8a, 0x1d, 0x74, 0xed, 0x30, 0x9e, 0xa0,
//                0xf1, 0xa0, 0xaa, 0xe3, 0x81, 0xf4, 0xb3, 0x08
//            ]
//        ),
//    );
//
//
//
//    signature::verify_bls_signature(SIGNATURE, PUBLIC_KEY, MESSAGE_HASH);
//}