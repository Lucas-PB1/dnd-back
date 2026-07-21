import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication, ValidationPipe } from '@nestjs/common';
import request from 'supertest';
import { App } from 'supertest/types';
import { AppModule } from '../src/app.module';
import { HttpExceptionFilter } from '../src/common/filters/http-exception.filter';

describe('Catalog API (e2e)', () => {
  let app: INestApplication<App>;

  beforeAll(async () => {
    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = moduleFixture.createNestApplication();
    app.useGlobalFilters(new HttpExceptionFilter());
    app.useGlobalPipes(
      new ValidationPipe({ whitelist: true, transform: true, transformOptions: { enableImplicitConversion: true } }),
    );
    await app.init();
  });

  afterAll(async () => {
    await app.close();
  });

  it('GET /health', () =>
    request(app.getHttpServer())
      .get('/health')
      .expect(200)
      .expect((res) => {
        expect(res.body.status).toBeDefined();
      }));

  it('GET /classes returns paginated list', () =>
    request(app.getHttpServer())
      .get('/classes')
      .expect(200)
      .expect((res) => {
        expect(res.body.data).toBeInstanceOf(Array);
        expect(res.body.meta.total).toBeGreaterThanOrEqual(12);
      }));

  it('GET /classes/fighter', () =>
    request(app.getHttpServer()).get('/classes/fighter').expect(200));

  it('GET /classes/fighter/subclasses', () =>
    request(app.getHttpServer())
      .get('/classes/fighter/subclasses')
      .expect(200)
      .expect((res) => {
        expect(res.body.data).toBeInstanceOf(Array);
        expect(res.body.meta.total).toBeGreaterThanOrEqual(4);
        expect(res.body.data.some((s: { slug: string }) => s.slug === 'champion')).toBe(true);
      }));

  it('GET /classes/invalid-slug/subclasses returns 404', () =>
    request(app.getHttpServer())
      .get('/classes/invalid-slug/subclasses')
      .expect(404));

  it('GET /classes/invalid returns 404 with body', () =>
    request(app.getHttpServer())
      .get('/classes/invalid-slug')
      .expect(404)
      .expect((res) => {
        expect(res.body.statusCode).toBe(404);
        expect(res.body.path).toContain('/classes/invalid-slug');
      }));

  it('GET /subclasses/champion', () =>
    request(app.getHttpServer())
      .get('/subclasses/champion')
      .expect(200)
      .expect((res) => {
        expect(res.body.slug).toBe('champion');
        expect(res.body.classSlug).toBe('fighter');
      }));

  it('GET /subclasses/invalid-slug returns 404', () =>
    request(app.getHttpServer()).get('/subclasses/invalid-slug').expect(404));

  it('GET /subclasses/champion/mechanics', () =>
    request(app.getHttpServer())
      .get('/subclasses/champion/mechanics')
      .expect(200)
      .expect((res) => {
        expect(res.body.meta.total).toBeGreaterThan(0);
      }));

  it('GET /subclasses/life/spells', () =>
    request(app.getHttpServer())
      .get('/subclasses/life/spells')
      .expect(200)
      .expect((res) => {
        expect(res.body.meta.total).toBeGreaterThan(0);
      }));

  it('GET /species', () =>
    request(app.getHttpServer())
      .get('/species')
      .expect(200)
      .expect((res) => {
        expect(res.body.meta.total).toBeGreaterThanOrEqual(10);
      }));

  it('GET /species/dwarf', () =>
    request(app.getHttpServer()).get('/species/dwarf').expect(200));

  it('GET /backgrounds/acolyte', () =>
    request(app.getHttpServer()).get('/backgrounds/acolyte').expect(200));

  it('GET /backgrounds/acolyte/equipment', () =>
    request(app.getHttpServer())
      .get('/backgrounds/acolyte/equipment')
      .expect(200)
      .expect((res) => {
        expect(res.body.data.length).toBeGreaterThan(0);
      }));

  it('GET /backgrounds/acolyte/skills', () =>
    request(app.getHttpServer())
      .get('/backgrounds/acolyte/skills')
      .expect(200)
      .expect((res) => {
        expect(res.body.meta.total).toBeGreaterThan(0);
        expect(res.body.data.some((s: { slug: string }) => s.slug === 'insight')).toBe(
          true,
        );
      }));

  it('GET /backgrounds/artisan/tools excludes thief and navigator tools', () =>
    request(app.getHttpServer())
      .get('/backgrounds/artisan/tools?limit=50')
      .expect(200)
      .expect((res) => {
        const slugs = res.body.data.map((row: { itemSlug: string }) => row.itemSlug);
        expect(slugs.length).toBeGreaterThanOrEqual(10);
        expect(slugs).not.toContain('ferramentas-de-ladrao');
        expect(slugs).not.toContain('ferramentas-de-navegador');
      }));

  it('GET /backgrounds/entertainer/tools lists musical instruments', () =>
    request(app.getHttpServer())
      .get('/backgrounds/entertainer/tools?limit=50')
      .expect(200)
      .expect((res) => {
        const slugs = res.body.data.map((row: { itemSlug: string }) => row.itemSlug);
        expect(slugs).toContain('alaude');
        expect(slugs).toContain('flauta');
        expect(slugs).not.toContain('instrumento-musical');
      }));

  it('GET /backgrounds/guard/tools lists only gaming sets', () =>
    request(app.getHttpServer())
      .get('/backgrounds/guard/tools?limit=50')
      .expect(200)
      .expect((res) => {
        const slugs = res.body.data.map((row: { itemSlug: string }) => row.itemSlug);
        expect(slugs).toEqual(
          expect.arrayContaining([
            'conjunto-de-dados',
            'xadrez-do-dragao',
            'baralho',
            'ante-dos-tres-dragoes',
          ]),
        );
        expect(slugs).not.toContain('kit-de-veneno');
        expect(slugs).not.toContain('kit-de-disfarce');
      }));

  it('GET /spells returns paginated list', () =>
    request(app.getHttpServer())
      .get('/spells')
      .expect(200)
      .expect((res) => {
        expect(res.body.meta.total).toBeGreaterThanOrEqual(391);
      }));

  it('GET /spells/alarme', () =>
    request(app.getHttpServer()).get('/spells/alarme').expect(200));

  it('GET /classes/wizard/spells?maxLevel=1', () =>
    request(app.getHttpServer())
      .get('/classes/wizard/spells?maxLevel=1')
      .expect(200)
      .expect((res) => {
        expect(res.body.data.every((s: { level: number }) => s.level <= 1)).toBe(true);
      }));

  it('GET /classes/wizard/spell-slots', () =>
    request(app.getHttpServer())
      .get('/classes/wizard/spell-slots')
      .expect(200)
      .expect((res) => {
        expect(res.body.meta.total).toBeGreaterThanOrEqual(20);
      }));

  it('GET /classes/fighter/equipment', () =>
    request(app.getHttpServer())
      .get('/classes/fighter/equipment')
      .expect(200)
      .expect((res) => {
        expect(res.body.data.length).toBeGreaterThan(0);
      }));

  it('GET /classes/fighter/skills', () =>
    request(app.getHttpServer())
      .get('/classes/fighter/skills')
      .expect(200)
      .expect((res) => {
        expect(res.body.meta.total).toBeGreaterThan(0);
      }));

  it('GET /feats/alert', () =>
    request(app.getHttpServer()).get('/feats/alert').expect(200));

  it('GET /skills/athletics', () =>
    request(app.getHttpServer()).get('/skills/athletics').expect(200));

  it('GET /abilities', () =>
    request(app.getHttpServer())
      .get('/abilities')
      .expect(200)
      .expect((res) => {
        expect(res.body.meta.total).toBe(6);
      }));

  it('GET /weapons/longsword', () =>
    request(app.getHttpServer()).get('/weapons/longsword').expect(200));

  it('GET /armor/leather', () =>
    request(app.getHttpServer()).get('/armor/leather').expect(200));

  it('GET /species/dwarf/traits', () =>
    request(app.getHttpServer())
      .get('/species/dwarf/traits')
      .expect(200)
      .expect((res) => {
        expect(res.body.meta.total).toBeGreaterThan(0);
      }));

  it('GET /subclasses/battle-master/options?level=5', () =>
    request(app.getHttpServer())
      .get('/subclasses/battle-master/options?level=5')
      .expect(200)
      .expect((res) => {
        expect(res.body.data.length).toBeGreaterThan(0);
      }));

  it('GET /species/human/trait-choices includes Versátil origin feats', () =>
    request(app.getHttpServer())
      .get('/species/human/trait-choices?limit=100')
      .expect(200)
      .expect((res) => {
        const kinds = new Set(res.body.data.map((row: { choiceKind: string }) => row.choiceKind));
        expect(kinds.has('human_skill')).toBe(true);
        expect(kinds.has('human_size')).toBe(true);
        expect(kinds.has('human_origin_feat')).toBe(true);
        expect(
          res.body.data.some(
            (row: { traitName: string }) => row.traitName === 'Versátil',
          ),
        ).toBe(true);
      }));

  it('GET /species/elf/trait-choices includes lineage, senses and casting', () =>
    request(app.getHttpServer())
      .get('/species/elf/trait-choices?limit=100')
      .expect(200)
      .expect((res) => {
        const kinds = new Set(
          res.body.data.map((row: { choiceKind: string }) => row.choiceKind),
        );
        expect(kinds.has('elf_lineage')).toBe(true);
        expect(kinds.has('elf_keen_senses')).toBe(true);
        expect(kinds.has('elf_casting_ability')).toBe(true);
      }));

  it('GET /species/gnome/trait-choices includes lineage and casting', () =>
    request(app.getHttpServer())
      .get('/species/gnome/trait-choices?limit=50')
      .expect(200)
      .expect((res) => {
        const kinds = new Set(
          res.body.data.map((row: { choiceKind: string }) => row.choiceKind),
        );
        expect(kinds.has('gnome_lineage')).toBe(true);
        expect(kinds.has('gnome_casting_ability')).toBe(true);
      }));

  it('GET /species/goliath/trait-choices includes giant ancestry', () =>
    request(app.getHttpServer())
      .get('/species/goliath/trait-choices?limit=50')
      .expect(200)
      .expect((res) => {
        const kinds = new Set(
          res.body.data.map((row: { choiceKind: string }) => row.choiceKind),
        );
        expect(kinds.has('giant_ancestry')).toBe(true);
        expect(res.body.data.length).toBeGreaterThanOrEqual(6);
      }));

  it('GET /species/tiefling/trait-choices includes legacy, casting and size', () =>
    request(app.getHttpServer())
      .get('/species/tiefling/trait-choices?limit=50')
      .expect(200)
      .expect((res) => {
        const kinds = new Set(
          res.body.data.map((row: { choiceKind: string }) => row.choiceKind),
        );
        expect(kinds.has('infernal_legacy')).toBe(true);
        expect(kinds.has('infernal_casting_ability')).toBe(true);
        expect(kinds.has('tiefling_size')).toBe(true);
      }));

  it('GET /species/aasimar/trait-choices includes size', () =>
    request(app.getHttpServer())
      .get('/species/aasimar/trait-choices?limit=20')
      .expect(200)
      .expect((res) => {
        const kinds = new Set(
          res.body.data.map((row: { choiceKind: string }) => row.choiceKind),
        );
        expect(kinds.has('aasimar_size')).toBe(true);
      }));

  it('GET /alignments', () =>
    request(app.getHttpServer())
      .get('/alignments')
      .expect(200)
      .expect((res) => {
        expect(res.body.meta.total).toBe(9);
      }));

  it('GET /languages', () =>
    request(app.getHttpServer())
      .get('/languages')
      .expect(200)
      .expect((res) => {
        expect(res.body.meta.total).toBeGreaterThanOrEqual(10);
      }));

  it('GET /character-levels', () =>
    request(app.getHttpServer())
      .get('/character-levels')
      .expect(200)
      .expect((res) => {
        expect(res.body.meta.total).toBe(20);
        expect(res.body.data[0].level).toBe(1);
      }));

  it('GET /backgrounds/invalid returns 404', () =>
    request(app.getHttpServer()).get('/backgrounds/invalid').expect(404));
});
