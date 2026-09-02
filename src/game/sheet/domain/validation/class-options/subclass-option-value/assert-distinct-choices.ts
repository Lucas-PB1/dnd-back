import { BadRequestException } from '@nestjs/common';
import { SubclassOptionDto } from '@game/sheet/dto/character-sheet.dto';
import { BLOOD_STRIKE_OPTION_KEY_RE } from '../subclass-option-effects';

export function assertDistinctBloodStrikes(
  options: SubclassOptionDto[],
): void {
  const values = options
    .filter((entry) => BLOOD_STRIKE_OPTION_KEY_RE.test(entry.optionKey))
    .map((entry) => entry.valueId)
    .filter(Boolean);
  if (new Set(values).size !== values.length) {
    throw new BadRequestException(
      'Golpes de Sangue devem ser diferentes entre si',
    );
  }
}

export function assertDistinctAcrossKeys(
  options: SubclassOptionDto[],
  keys: readonly string[],
): void {
  const values = options
    .filter((entry) => keys.includes(entry.optionKey))
    .map((entry) => entry.valueId)
    .filter(Boolean);
  if (new Set(values).size !== values.length) {
    throw new BadRequestException(
      'Subclass spell choices must be different',
    );
  }
}
