///|
// start prelude and builtin names 1
fn println(msg : String) -> String {
  "log: \{msg}"
}

///|
fn shadowed_println() -> String {
  println("hello")
}

///|
fn builtin_answer() -> Int {
  let answer : Int = 42
  answer
}
// end prelude and builtin names 1

///|
test {
  inspect(shadowed_println(), content="log: hello")
  inspect(builtin_answer(), content="42")
}
