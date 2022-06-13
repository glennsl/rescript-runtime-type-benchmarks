let makeStrictStruct = () => {
  let nestedStruct = S.record3(
    ~fields=(("foo", S.string()), ("num", S.float()), ("bool", S.bool())),
    ~constructor=((foo, num, bool)) => {Benchmark.Data.foo: foo, num: num, bool: bool}->Ok,
    (),
  )
  S.record7(
    ~fields=(
      ("number", S.float()),
      ("negNumber", S.float()),
      ("maxNumber", S.float()),
      ("string", S.string()),
      ("longString", S.string()),
      ("boolean", S.bool()),
      ("deeplyNested", nestedStruct),
    ),
    ~constructor=((number, negNumber, maxNumber, string, longString, boolean, deeplyNested)) => {
      {
        Benchmark.Data.number: number,
        negNumber: negNumber,
        maxNumber: maxNumber,
        string: string,
        longString: longString,
        boolean: boolean,
        deeplyNested: deeplyNested,
      }->Ok
    },
    (),
  )
}

let makeSafeStruct = () => {
  let nestedStruct =
    S.record3(
      ~fields=(("foo", S.string()), ("num", S.float()), ("bool", S.bool())),
      ~constructor=((foo, num, bool)) => {Benchmark.Data.foo: foo, num: num, bool: bool}->Ok,
      (),
    )->S.Record.strip
  S.record7(
    ~fields=(
      ("number", S.float()),
      ("negNumber", S.float()),
      ("maxNumber", S.float()),
      ("string", S.string()),
      ("longString", S.string()),
      ("boolean", S.bool()),
      ("deeplyNested", nestedStruct),
    ),
    ~constructor=((number, negNumber, maxNumber, string, longString, boolean, deeplyNested)) => {
      {
        Benchmark.Data.number: number,
        negNumber: negNumber,
        maxNumber: maxNumber,
        string: string,
        longString: longString,
        boolean: boolean,
        deeplyNested: deeplyNested,
      }->Ok
    },
    (),
  )->S.Record.strip
}

Benchmark.Case.make(
  "rescript-struct",
  "parseSafe",
  () => {
    let struct = makeSafeStruct()
    (. data) => {
      switch data->S.parseWith(struct) {
      | Ok(parsed) => parsed
      | Error(message) => Js.Exn.raiseError(message)
      }
    }
  },
  (),
)

Benchmark.Case.make(
  "rescript-struct",
  "parseStrict",
  () => {
    let struct = makeStrictStruct()
    (. data) => {
      switch data->S.parseWith(struct) {
      | Ok(parsed) => parsed
      | Error(message) => Js.Exn.raiseError(message)
      }
    }
  },
  (),
)

Benchmark.Case.make(
  "rescript-struct",
  "assertLoose",
  () => {
    let struct = makeSafeStruct()
    (. data) => {
      switch data->S.parseWith(struct) {
      | Ok(_) => true
      | Error(message) => Js.Exn.raiseError(message)
      }
    }
  },
  (),
)

Benchmark.Case.make(
  "rescript-struct",
  "assertStrict",
  () => {
    let struct = makeStrictStruct()
    (. data) => {
      switch data->S.parseWith(struct) {
      | Ok(_) => true
      | Error(message) => Js.Exn.raiseError(message)
      }
    }
  },
  (),
)
