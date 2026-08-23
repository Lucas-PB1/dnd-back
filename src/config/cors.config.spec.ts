import { corsConfig } from './cors.config';

describe('corsConfig', () => {
  const originalFrontend = process.env.FRONTEND_URL;

  afterEach(() => {
    if (originalFrontend === undefined) delete process.env.FRONTEND_URL;
    else process.env.FRONTEND_URL = originalFrontend;
  });

  function originCb(): {
    origin: (
      origin: string | undefined,
      callback: (err: Error | null, allow?: boolean) => void,
    ) => void;
  } {
    return corsConfig() as {
      origin: (
        origin: string | undefined,
        callback: (err: Error | null, allow?: boolean) => void,
      ) => void;
    };
  }

  it('allows requests with no Origin header', () => {
    const cb = jest.fn();
    originCb().origin(undefined, cb);
    expect(cb).toHaveBeenCalledWith(null, true);
  });

  it('allows localhost and 127.0.0.1 frontends', () => {
    const cb1 = jest.fn();
    originCb().origin('http://localhost:3001', cb1);
    expect(cb1).toHaveBeenCalledWith(null, true);

    const cb2 = jest.fn();
    originCb().origin('http://127.0.0.1:3001', cb2);
    expect(cb2).toHaveBeenCalledWith(null, true);
  });

  it('allows FRONTEND_URL when set (single or comma-separated)', () => {
    process.env.FRONTEND_URL = 'https://app.example.com, https://other.example.com';
    const cb1 = jest.fn();
    originCb().origin('https://app.example.com', cb1);
    expect(cb1).toHaveBeenCalledWith(null, true);

    const cb2 = jest.fn();
    originCb().origin('https://other.example.com', cb2);
    expect(cb2).toHaveBeenCalledWith(null, true);
  });

  it('allows vercel.app preview origins', () => {
    const cb = jest.fn();
    originCb().origin('https://dnd-front-abc.vercel.app', cb);
    expect(cb).toHaveBeenCalledWith(null, true);
  });

  it('rejects unknown origins', () => {
    const cb = jest.fn();
    originCb().origin('https://evil.example', cb);
    expect(cb).toHaveBeenCalledWith(null, false);
  });
});
