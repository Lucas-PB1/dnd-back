# Estrutura de módulos

```
src/
├── main.ts
├── app.module.ts
├── config/
│   └── database.config.ts
├── catalog/
│   ├── catalog.module.ts
│   ├── classes/
│   ├── spells/
│   ├── species/
│   ├── backgrounds/
│   └── equipment/
└── entities/
    └── views/
        └── v-phb-class.entity.ts
```

## catalog.module.ts

Importa submódulos por domínio; exporta services se necessário.

## Convenções

- Um controller por recurso de catálogo
- Service injeta `@InjectRepository` da view ou entity
- DTOs em pasta `dto/` do módulo
