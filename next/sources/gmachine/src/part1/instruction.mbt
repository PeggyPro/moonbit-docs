// start instr definition

enum Instruction {
  Unwind
  PushGlobal(String)
  PushInt(Int)
  PushArg(Int)
  MkApp
  Update(Int)
  Pop(Int)
} derive(Eq, Debug)
// end instr definition
