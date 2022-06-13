@decco.decode
type nested = {foo: string, num: float, bool: bool}
@decco.decode
type data = {
  number: float,
  negNumber: float,
  maxNumber: float,
  string: string,
  longString: string,
  boolean: bool,
  deeplyNested: nested,
}

Benchmark.Case.make(
  "decco",
  "parseSafe",
  () => {
    (. data) => {
      switch data->data_decode {
      | Ok(value) => value
      | Error(decodeError) => Js.Exn.raiseError(decodeError.message)
      }
    }
  },
  (),
)

Benchmark.Case.make(
  "decco",
  "parseStrict",
  () => {
    (. data) => {
      switch data->data_decode {
      | Ok(value) => value
      | Error(decodeError) => Js.Exn.raiseError(decodeError.message)
      }
    }
  },
  ~options={disabled: true},
  (),
)

Benchmark.Case.make(
  "decco",
  "assertLoose",
  () => {
    (. data) => {
      switch data->data_decode {
      | Ok(_) => true
      | Error(decodeError) => Js.Exn.raiseError(decodeError.message)
      }
    }
  },
  (),
)

Benchmark.Case.make(
  "decco",
  "assertStrict",
  () => {
    (. data) => {
      switch data->data_decode {
      | Ok(_) => true
      | Error(decodeError) => Js.Exn.raiseError(decodeError.message)
      }
    }
  },
  ~options={disabled: true},
  (),
)
