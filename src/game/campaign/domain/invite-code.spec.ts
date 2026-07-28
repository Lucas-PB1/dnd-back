jest.mock('crypto', () => ({
  randomBytes: jest.fn(),
}));

import { randomBytes } from 'crypto';
import { generateCampaignInviteCode } from './invite-code';

const mockRandomBytes = randomBytes as jest.MockedFunction<
  (size: number) => Buffer
>;

describe('invite-code', () => {
  beforeEach(() => {
    mockRandomBytes.mockReset();
  });

  it('builds a code of the requested length from the safe alphabet', () => {
    mockRandomBytes.mockReturnValue(Buffer.from([0, 1, 2, 3, 24, 25, 26, 27]));
    expect(generateCampaignInviteCode(8)).toBe('ABCD2345');
    expect(mockRandomBytes).toHaveBeenCalledWith(8);
  });

  it('omits ambiguous characters I, O, 0 and 1', () => {
    const alphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    mockRandomBytes.mockReturnValue(
      Buffer.from(Array.from({ length: alphabet.length }, (_, i) => i)),
    );
    const code = generateCampaignInviteCode(alphabet.length);
    expect(code).toHaveLength(alphabet.length);
    expect(code).toMatch(/^[A-Z2-9]+$/);
    expect(code).not.toMatch(/[IO01]/);
  });

  it('defaults to length 8', () => {
    mockRandomBytes.mockReturnValue(Buffer.alloc(8, 0));
    expect(generateCampaignInviteCode()).toHaveLength(8);
  });
});
