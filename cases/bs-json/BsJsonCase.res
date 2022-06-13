let makeDecoder = () => {
  let nested = json => {
    open! Json.Decode
    {
      Benchmark.Data.foo: json |> field("foo", string),
      num: json |> field("num", float),
      bool: json |> field("bool", bool),
    }
  }
  json => {
    open! Json.Decode
    {
      Benchmark.Data.number: json |> field("number", float),
      negNumber: json |> field("negNumber", float),
      maxNumber: json |> field("maxNumber", float),
      string: json |> field("string", string),
      longString: json |> field("longString", string),
      boolean: json |> field("boolean", bool),
      deeplyNested: json |> field("deeplyNested", nested),
    }
  }
}

Benchmark.Case.make(
  "bs-json",
  "parseSafe",
  () => {
    let decoder = makeDecoder()
    decoder
  },
  (),
)

Benchmark.Case.make(
  "bs-json",
  "parseStrict",
  () => {
    let decoder = makeDecoder()
    decoder
  },
  ~options={disabled: true},
  (),
)

Benchmark.Case.make(
  "bs-json",
  "assertLoose",
  () => {
    let decoder = makeDecoder()
    data => {
      data |> decoder |> ignore
      true
    }
  },
  (),
)

Benchmark.Case.make(
  "bs-json",
  "assertStrict",
  () => {
    let decoder = makeDecoder()
    data => {
      data |> decoder |> ignore
      true
    }
  },
  ~options={disabled: true},
  (),
)
