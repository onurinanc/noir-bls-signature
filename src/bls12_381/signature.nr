use dep::std::println;

use dep::bigint::prime_field::PrimeField as Fp;

use crate::bls12_381::swcurve::Point;
use crate::bls12_381::fp12::Fp12;
use crate::bls12_381::fp6::Fp6;
use crate::bls12_381::fp2::Fp2;
use crate::bls12_381::g2::G2Point;
use crate::bls12_381::pairing;
use crate::bls12_381;

fn verify_bls_signature(signature: G2Point, public_key: Point, message_hash: G2Point) {
    let g1: bls12_381::BLS12_381 = bls12_381::bls12_381();
    let lhs = pairing::pair(signature, g1.curve.gen);
    let rhs = pairing::pair(message_hash, public_key);
    assert(lhs.eq(rhs));
}