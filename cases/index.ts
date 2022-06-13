export const cases = [
  'ajv',
  'bueno',
  'class-validator',
  'computed-types',
  'decoders',
  'io-ts',
  'jointz',
  'json-decoder',
  'marshal',
  'mojotech-json-type-validation',
  'myzod',
  'ok-computer',
  'purify-ts',
  'rulr',
  'runtypes',
  'simple-runtypes',
  'spectypes',
  'superstruct',
  'suretype',
  'toi',
  'ts-interface-checker',
  'ts-json-validator',
  'ts-utils',
  'tson',
  'typeofweb-schema',
  'valita',
  'yup',
  'zod',
  'rescript-struct',
  'rescript-jzon',
  'bs-json',
] as const;

export type CaseName = typeof cases[number];

export async function importCase(caseName: CaseName) {
  await import('./' + caseName);
}
