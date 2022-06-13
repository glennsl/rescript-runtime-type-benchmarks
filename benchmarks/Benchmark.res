module Data = {
  type nested = {foo: string, num: float, bool: bool}
  type t = {
    number: float,
    negNumber: float,
    maxNumber: float,
    string: string,
    longString: string,
    boolean: bool,
    deeplyNested: nested,
  }
}

module Case = {
  type options = {disabled: bool}
  @module("./index")
  external make: (
    string,
    string,
    (unit, . 'data) => 'parsedData,
    ~options: options=?,
    unit,
  ) => unit = "createCase"
}
