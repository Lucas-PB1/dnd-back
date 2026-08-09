import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbEdition } from '@entities/phb-edition.entity';
import { EditionResponseDto } from '../dto/edition-response.dto';

@Injectable()
export class FindEditionsQuery {
  constructor(
    @InjectRepository(PhbEdition)
    private readonly editions: Repository<PhbEdition>,
  ) {}

  async execute(): Promise<EditionResponseDto[]> {
    const rows = await this.editions.find({ order: { slug: 'ASC' } });
    return rows.map((row) => ({
      slug: row.slug,
      label: row.label,
      book: row.book,
      language: row.language,
      notes: row.notes,
    }));
  }
}
