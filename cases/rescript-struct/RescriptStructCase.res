let makeStruct = (~isStrict) => {
  let nestedStruct = {
    let struct = S.record3(
      ~fields=(("foo", S.string()), ("num", S.float()), ("bool", S.bool())),
      ~constructor=((foo, num, bool)) => {Benchmark.Data.foo: foo, num: num, bool: bool}->Ok,
      (),
    )
    if isStrict {
      struct
    } else {
      struct->S.Record.strip
    }
  }
  let struct = S.record7(
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
  if isStrict {
    struct
  } else {
    struct->S.Record.strip
  }
}

Benchmark.Case.make(
  "rescript-struct",
  "parseSafe",
  () => {
    let struct = makeStruct(~isStrict=false)
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
    let struct = makeStruct(~isStrict=true)
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
    let struct = makeStruct(~isStrict=false)
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
    let struct = makeStruct(~isStrict=true)
    (. data) => {
      switch data->S.parseWith(struct) {
      | Ok(_) => true
      | Error(message) => Js.Exn.raiseError(message)
      }
    }
  },
  (),
)
