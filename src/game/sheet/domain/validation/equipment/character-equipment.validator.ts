import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { assertUnique } from '@common/assert';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { VPhbClassEquipment } from '@entities/views/v-phb-class-equipment.entity';
import { VPhbBackgroundEquipment } from '@entities/views/v-phb-background-equipment.entity';
import { CharacterSheetInput } from '@game/sheet/domain/character-sheet.types';
import { CharacterSheetContext } from '@game/sheet/domain/character-sheet.types';
import { resolveStartingGoldPieces } from '@game/inventory/domain/resolve-starting-gold';

@Injectable()
export class CharacterEquipmentValidator {
  constructor(
    private readonly catalogLookup: CatalogLookupService,
    @InjectRepository(VPhbClassEquipment)
    private readonly classEquipmentRepo: Repository<VPhbClassEquipment>,
    @InjectRepository(VPhbBackgroundEquipment)
    private readonly backgroundEquipmentRepo: Repository<VPhbBackgroundEquipment>,
  ) {}

  async validateEquipment(
    items: NonNullable<CharacterSheetInput['equipment']>,
    ctx: CharacterSheetContext,
  ): Promise<void> {
    for (const item of items) {
      if (
        item.source === 'background' &&
        item.packageSlug === 'gold'
      ) {
        const background = await this.catalogLookup.findBackgroundOrFail(
          ctx.backgroundSlug,
        );
        if (
          background.equipmentGoldOption == null ||
          background.equipmentGoldOption <= 0
        ) {
          throw new BadRequestException(
            `Background '${ctx.backgroundSlug}' does not offer a gold equipment option`,
          );
        }
        if (item.itemSlug) {
          throw new BadRequestException(
            'Gold background equipment option cannot include item rows',
          );
        }
        continue;
      }

      if (item.source === 'class') {
        await this.assertEquipmentPackage(
          await this.classEquipmentRepo.find({
            where: { classSlug: ctx.classSlug, packageSlug: item.packageSlug },
          }),
          item.packageSlug,
          item.itemSlug,
          'class',
          ctx.classSlug,
        );
      } else {
        await this.assertEquipmentPackage(
          await this.backgroundEquipmentRepo.find({
            where: { backgroundSlug: ctx.backgroundSlug, packageSlug: item.packageSlug },
          }),
          item.packageSlug,
          item.itemSlug,
          'background',
          ctx.backgroundSlug,
        );
      }
    }
  }

  /** PO inicial das escolhas de equipamento (criação). */
  async resolveStartingGold(
    equipment: CharacterSheetInput['equipment'],
    ctx: Pick<CharacterSheetContext, 'classSlug' | 'backgroundSlug'>,
  ): Promise<number> {
    const background = await this.catalogLookup.findBackgroundOrFail(
      ctx.backgroundSlug,
    );
    const classPackages = [
      ...new Set(
        (equipment ?? [])
          .filter((row) => row.source === 'class')
          .map((row) => row.packageSlug),
      ),
    ];
    const backgroundPackages = [
      ...new Set(
        (equipment ?? [])
          .filter((row) => row.source === 'background')
          .map((row) => row.packageSlug),
      ),
    ];

    const classEquipmentRows =
      classPackages.length === 0
        ? []
        : (
            await Promise.all(
              classPackages.map((packageSlug) =>
                this.classEquipmentRepo.find({
                  where: { classSlug: ctx.classSlug, packageSlug },
                }),
              ),
            )
          ).flat();

    const backgroundEquipmentRows =
      backgroundPackages.length === 0
        ? []
        : (
            await Promise.all(
              backgroundPackages.map((packageSlug) =>
                this.backgroundEquipmentRepo.find({
                  where: { backgroundSlug: ctx.backgroundSlug, packageSlug },
                }),
              ),
            )
          ).flat();

    return resolveStartingGoldPieces({
      equipment,
      background: {
        equipmentGoldOption: background.equipmentGoldOption ?? null,
      },
      classEquipmentRows,
      backgroundEquipmentRows,
    });
  }

  private async assertEquipmentPackage(
    rows: { itemSlug: string | null; choiceText: string | null }[],
    packageSlug: string,
    itemSlug: string | undefined,
    source: 'class' | 'background',
    ownerSlug: string,
  ): Promise<void> {
    if (rows.length === 0) {
      throw new BadRequestException(
        `${source === 'class' ? 'Class' : 'Background'} equipment package '${packageSlug}' not found for '${ownerSlug}'`,
      );
    }
    if (!itemSlug) return;
    if (rows.some((row) => row.itemSlug === itemSlug)) return;

    if (rows.some((row) => row.choiceText != null)) {
      await this.catalogLookup.assertItemInCatalog(itemSlug);
      return;
    }

    throw new BadRequestException(
      `Item '${itemSlug}' is not in ${source} package '${packageSlug}'`,
    );
  }

  async validateLanguageSlugs(languageSlugs: string[]): Promise<void> {
    assertUnique(languageSlugs, 'Duplicate language slugs are not allowed');
    for (const slug of languageSlugs) {
      await this.catalogLookup.assertLanguageSlug(slug);
    }
  }

  async validateAbilityGenerationMethod(slug: string): Promise<void> {
    await this.catalogLookup.assertAbilityGenerationMethodSlug(slug);
  }
}
