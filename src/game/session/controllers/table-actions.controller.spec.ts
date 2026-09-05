import 'reflect-metadata';
import { PATH_METADATA, METHOD_METADATA } from '@nestjs/common/constants';
import { RequestMethod } from '@nestjs/common';
import { TableActionsController } from './table-actions.controller';

function collectRouteMethods(ctor: new (...args: never[]) => unknown) {
  const out: { name: string; path: string; method: RequestMethod }[] = [];
  let cur: object | null = ctor.prototype;
  while (cur && cur !== Object.prototype) {
    for (const name of Object.getOwnPropertyNames(cur)) {
      if (name === 'constructor') continue;
      const fn = Object.getOwnPropertyDescriptor(cur, name)?.value as
        | ((...args: unknown[]) => unknown)
        | undefined;
      if (typeof fn !== 'function') continue;
      const path = Reflect.getMetadata(PATH_METADATA, fn) as string | undefined;
      const method = Reflect.getMetadata(METHOD_METADATA, fn) as
        | RequestMethod
        | undefined;
      if (path != null && method != null) {
        out.push({ name, path, method });
      }
    }
    cur = Object.getPrototypeOf(cur);
  }
  return out;
}

describe('TableActionsController routes', () => {
  it('exposes all class table-action POST routes via mixins', () => {
    const routes = collectRouteMethods(
      TableActionsController as unknown as new (...args: never[]) => unknown,
    );
    const paths = routes.map((r) => r.path).sort();
    expect(paths).toEqual(
      [
        ':id/barbarian/table-action',
        ':id/bard/table-action',
        ':id/cleric/table-action',
        ':id/druid/table-action',
        ':id/feat/table-action',
        ':id/fighter/table-action',
        ':id/gunslinger/table-action',
        ':id/monk/table-action',
        ':id/monster-hunter/table-action',
        ':id/transformation/table-action',
        ':id/paladin/table-action',
        ':id/ranger/table-action',
        ':id/rogue/table-action',
        ':id/sorcerer/table-action',
        ':id/warlock/table-action',
        ':id/wizard/table-action',
      ].sort(),
    );
    expect(routes.every((r) => r.method === RequestMethod.POST)).toBe(true);
  });
});
