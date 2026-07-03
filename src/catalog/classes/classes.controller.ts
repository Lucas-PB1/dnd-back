import { Controller, Get, Param } from '@nestjs/common';
import { ClassesService } from './classes.service';
import { ClassResponseDto } from './dto/class-response.dto';

@Controller('classes')
export class ClassesController {
  constructor(private readonly classesService: ClassesService) {}

  @Get()
  findAll(): Promise<ClassResponseDto[]> {
    return this.classesService.findAll();
  }

  @Get(':slug')
  findOne(@Param('slug') slug: string): Promise<ClassResponseDto> {
    return this.classesService.findBySlug(slug);
  }
}
