# noir-bls12_381 signature verification

BLS12_381 Elliptic Curve Pairing and Signature Verification Library

- **This implementation has not been reviewed or audited. Use at your own risk.**
- This implementation targets Noir version 0.9.0 or higher
- This implementation currently requires **a specific fork https://github.com/onurinanc/noir-bigint` of noir-bigint library https://github.com/shuklaayush/noir-bigint**, workspace dependency will be added in the future for a better use

## How to test the library
1. Use following commands to use two libraries in your local

`git clone https://github.com/onurinanc/noir-bls12_381`

2. To add the noir-bigint dependency, use a forked version of https://github.com/shuklaayush/noir-bigint, specifically built for bls12_381 prime

`git clone https://github.com/onurinanc/noir-bigint-bls12_381`

3. Test the files using the following commands inside the noir-bls12_381.
`nargo test`

## Documentation

### Curve Description and Usage
BLS12_381 is a pairing-friendly elliptic curve construction. This includes two elliptic curve constructions which are G1: E(Fp) and G2: E(Fp^2).

G1 curve is `y^2 = x^3 + 4`
Field modulus is `4002409555221667393417789825735904156556882819939007885332058136124031650490837864442687629129015664037894272559787`
The order of the elliptic curves is `52435875175126190479447740508185965837690552500527637822603658699938581184513`
The generator of the G1 is the (3685416753713387016781088315183077757961620795782546409894578378688607592378376318836054947676345821548104185464507, 1339506544944476473020471379941921221584933875938349620426543736416511423956333506472724655353366534992391756441569)

The method and parameters for constructing the G1 curve is in the src/bls12_381.nr

```
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
```

G2 is constructed using the Fp^2 extension field. The method and the parameters for constructing the G2 curve is in the src/bls12_381.nr

```
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
```


You can create instances of the elliptic curves using

```
let g2: BLS12_381G2 = bls12_381_g2();
let g1: BLS12_381 = bls12_381();
```

You can test additions for G1 and G2 seperately using the following command in Noir

```
nargo test test_bls12_381_add1
nargo test test_bls12_381_g2_add1
```

### Features
- You can verify bls signatures in a circuit by using the following function as it is specified

```
signature::verify_bls_signature(signature: G2Point, public_key: Point, message_hash: G2Point)
```


- fn pair(Q: G2Point, P: Point) -> Fp12

It's the pairing function. Q is an element of G2, and 
P is an element of G1.

- The `pair` calculates the pairing in Fp12

- `Point` is a point on the G1 curve
- `G2Point` is a point on the G2 curve

You can create Point and G2Point as the following function signatures

- `Point::from_affine(x: Fp, y: Fp)`
- `G2Point::from_affine(x: Fp2, y:Fp2)`

You can create Fp, Fp2, Fp6, Fp12 elements using the following examples

```
let fp_1 = Fp::from_bytes([
    0x29, 0x0b, 0x0e, 0x34, 0x32, 0x50, 0x16, 0x12,
    0x27, 0x7a, 0xca, 0x7b, 0x36, 0x15, 0xe1, 0xa5,
    0x2d, 0xed, 0x21, 0x22, 0x0c, 0x2a, 0xc7, 0xf3,
    0x33, 0x22, 0xea, 0xe2, 0x8d, 0x43, 0x48, 0x7e,
    0x34, 0x2d, 0xd5, 0xe7, 0x90, 0xb2, 0x60, 0x53,
    0x51, 0x06, 0x6b, 0xd8, 0xc1, 0x2e, 0x26, 0x09
]);

let fp_2 = Fp::from_u56(8);

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
```
## Benchmark
The project is compiled by the machine has the following properties:
`16 GB RAM, Intel Core i5-12450H`

Compilation time for the pairing function (optimal ate), which uses BLS12_381 Pairing Friendly Curve implemented in Noir, is `1.2 h`. 

The compilation time for the pairing function is less than [circom-pairing][https://github.com/yi-sun/circom-pairing#benchmarks],which is computed with a machine with better properties stated as `1.9 h`

The compilation time for BLS12_381 Signature Verification is approximately `2.4 h`, it is also less than [circom-pairing][https://github.com/yi-sun/circom-pairing#benchmarks], which is computed with a machine with better properties states that it is `3.2 h`

For testing purposes:
- Compilation time for the final_exponentiation takes ~8 minutes
- Compilation time for the miller_loop takes ~64 minutes: so you can reduce to loop to test. So, the following are the smaller loops for testing miller_loop:
    - for i in 0..2    -> ~0.5 minutes
    - for i in 0..8    -> ~4 minutes
    - for i in 0..10   -> ~6 minutes
    - for i in 0.12    -> ~8 minutes

## Contributing

Contributions are welcome! Please adhere to the following guidelines:

- Open a pull request with a clear description of your changes.
- Changes should aim to improve code efficiency or readability.
- Add appropriate tests, ensuring all pass before submission.

## Disclaimer
This is an **experimental software** and is provided on an "as is" and "as available" basis. We **do not give any warranties** and **will not be liable for any losses** incurred through any use of this code base.