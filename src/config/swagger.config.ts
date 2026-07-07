import type { SwaggerCustomOptions } from '@nestjs/swagger';

const SWAGGER_UI_VERSION = '5.32.8';
const SWAGGER_UI_CDN = `https://cdn.jsdelivr.net/npm/swagger-ui-dist@${SWAGGER_UI_VERSION}`;

/**
 * Na Vercel o bundle serverless não expõe arquivos de `swagger-ui-dist` em
 * `/api/swagger-ui-*.js`. CDN evita 404 nos assets estáticos.
 */
export function swaggerSetupOptions(): SwaggerCustomOptions {
  return {
    customCssUrl: `${SWAGGER_UI_CDN}/swagger-ui.css`,
    customJs: [
      `${SWAGGER_UI_CDN}/swagger-ui-bundle.js`,
      `${SWAGGER_UI_CDN}/swagger-ui-standalone-preset.js`,
    ],
    customfavIcon: `${SWAGGER_UI_CDN}/favicon-32x32.png`,
  };
}
