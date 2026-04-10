// start derive default struct

struct DeriveDefault {
  x : Int
  y : String?
} derive(Default, Eq)

test "derive default struct" {
  let p = DeriveDefault::default()
  assert_true(p == DeriveDefault::{ x: 0, y: None })
}
// end derive default struct

// start derive default enum

enum DeriveDefaultEnum {
  Case1(Int)
  Case2(label~ : String)
  Case3
} derive(Default, Eq)

test "derive default enum" {
  assert_true(DeriveDefaultEnum::default() == DeriveDefaultEnum::Case3)
}
// end derive default enum
