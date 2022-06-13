let makeCodec = () => {
  let nestedCodec = Jzon.object3(
    ({Benchmark.Data.foo: foo, num, bool}) => (foo, num, bool),
    ((foo, num, bool)) => {foo: foo, num: num, bool: bool}->Ok,
    Jzon.field("foo", Jzon.string),
    Jzon.field("num", Jzon.float),
    Jzon.field("bool", Jzon.bool),
  )
  Jzon.object7(
    ({
      Benchmark.Data.number: number,
      negNumber,
      maxNumber,
      string,
      longString,
      boolean,
      deeplyNested,
    }) => (number, negNumber, maxNumber, string, longString, boolean, deeplyNested),
    ((number, negNumber, maxNumber, string, longString, boolean, deeplyNested)) =>
      {
        number: number,
        negNumber: negNumber,
        maxNumber: maxNumber,
        string: string,
        longString: longString,
        boolean: boolean,
        deeplyNested: deeplyNested,
      }->Ok,
    Jzon.field("number", Jzon.float),
    Jzon.field("negNumber", Jzon.float),
    Jzon.field("maxNumber", Jzon.float),
    Jzon.field("string", Jzon.string),
    Jzon.field("longString", Jzon.string),
    Jzon.field("boolean", Jzon.bool),
    Jzon.field("deeplyNested", nestedCodec),
  )
}

Benchmark.Case.make(
  "rescript-jzon",
  "parseSafe",
  () => {
    let codec = makeCodec()
    (. data) => {
      switch data->Jzon.decodeWith(codec) {
      | Ok(parsed) => parsed
      | Error(_) => Js.Exn.raiseError("error")
      }
    }
  },
  (),
)

Benchmark.Case.make(
  "rescript-jzon",
  "parseStrict",
  () => {
    let codec = makeCodec()
    (. data) => {
      switch data->Jzon.decodeWith(codec) {
      | Ok(parsed) => parsed
      | Error(_) => Js.Exn.raiseError("error")
      }
    }
  },
  ~options={disabled: true},
  (),
)

Benchmark.Case.make(
  "rescript-jzon",
  "assertLoose",
  () => {
    let codec = makeCodec()
    (. data) => {
      switch data->Jzon.decodeWith(codec) {
      | Ok(_) => true
      | Error(_) => Js.Exn.raiseError("error")
      }
    }
  },
  (),
)

Benchmark.Case.make(
  "rescript-jzon",
  "assertStrict",
  () => {
    let codec = makeCodec()
    (. data) => {
      switch data->Jzon.decodeWith(codec) {
      | Ok(_) => true
      | Error(_) => Js.Exn.raiseError("error")
      }
    }
  },
  ~options={disabled: true},
  (),
)
