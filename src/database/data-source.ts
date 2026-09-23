import 'reflect-metadata';
import { DataSource } from 'typeorm';
import { createCliDataSourceOptions } from './cli-data-source-options';

export default new DataSource(createCliDataSourceOptions());
