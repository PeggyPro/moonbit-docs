// start derive show struct

struct MyStruct {
  x : Int
  y : Int
}

impl Show for MyStruct with output(self, logger) {
  logger.write_string("{x: \{self.x}, y: \{self.y}}")
}

test "derive show struct" {
  let p = MyStruct::{ x: 1, y: 2 }
  assert_eq(Show::to_string(p), "{x: 1, y: 2}")
}
// end derive show struct

// start derive show enum

enum MyEnum {
  Case1(Int)
  Case2(label~ : String)
  Case3
}

impl Show for MyEnum with output(self, logger) {
  match self {
    Case1(value) => logger.write_string("Case1(\{value})")
    Case2(label~) => logger.write_string("Case2(label=\"\{label}\")")
    Case3 => logger.write_string("Case3")
  }
}

test "derive show enum" {
  assert_eq(Show::to_string(MyEnum::Case1(42)), "Case1(42)")
  assert_eq(
    Show::to_string(MyEnum::Case2(label="hello")),
    "Case2(label=\"hello\")",
  )
  assert_eq(Show::to_string(MyEnum::Case3), "Case3")
}
// end derive show enum
