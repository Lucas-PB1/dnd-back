/** Nest mixin host: arity varies per composition layer. */
// eslint-disable-next-line @typescript-eslint/no-explicit-any -- Nest mixin ctor
export type NestMixinCtor = abstract new (...args: any[]) => object;
