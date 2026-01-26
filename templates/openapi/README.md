# OpenAPI Templates

This directory contains OpenAPI 3.1 specification templates for documenting REST APIs.

## Templates

| Template | Description |
|----------|-------------|
| [`openapi-minimal.yaml`](./openapi-minimal.yaml) | Bare-bones spec for quick starts |
| [`openapi-full.yaml`](./openapi-full.yaml) | Comprehensive spec with auth, pagination, webhooks |

## Quick Start

1. **Copy the template** to your project:

   ```bash
   mkdir -p openapi
   cp templates/openapi/openapi-minimal.yaml openapi/openapi.yaml
   ```

2. **Customize** the specification:
   - Update `info` section with your API details
   - Modify `servers` for your environments
   - Add/modify paths for your endpoints
   - Define your schemas in `components`

3. **Generate documentation** using the workflow:

   ```yaml
   # .github/workflows/docs-api.yml
   name: API Documentation
   on:
     push:
       paths:
         - 'openapi/**'
   jobs:
     build:
       runs-on: ubuntu-latest
       steps:
         - uses: actions/checkout@v4
         - name: Generate docs
           uses: redocly/redoc-action@v1
           with:
             spec: openapi/openapi.yaml
   ```

## Template Comparison

### Minimal Template

Best for:
- Getting started quickly
- Simple CRUD APIs
- Internal services

Features:
- Basic CRUD operations
- Simple error handling
- Minimal components

### Full Template

Best for:
- Production APIs
- Public APIs
- APIs requiring authentication

Features:
- JWT and API key authentication
- Pagination patterns (offset and cursor)
- Rate limiting headers
- Webhook definitions
- File uploads
- Comprehensive error responses

## OpenAPI Best Practices

### 1. Use Semantic Versioning

```yaml
info:
  version: 2.1.0
```

### 2. Define Reusable Components

```yaml
components:
  schemas:
    Error:
      type: object
      properties:
        code:
          type: string
        message:
          type: string

  responses:
    NotFound:
      description: Resource not found
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/Error'
```

### 3. Use Operation IDs

```yaml
paths:
  /users:
    get:
      operationId: listUsers  # Used for code generation
```

### 4. Add Examples

```yaml
schema:
  type: object
  properties:
    name:
      type: string
      example: John Doe
```

### 5. Document Security

```yaml
security:
  - bearerAuth: []

components:
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer
      bearerFormat: JWT
```

## Documentation Tools

### Redoc

Generate beautiful documentation:

```bash
npx @redocly/cli build-docs openapi/openapi.yaml -o docs/api.html
```

### Swagger UI

Interactive API explorer:

```bash
npx swagger-ui-watcher openapi/openapi.yaml
```

### Validation

Validate your spec:

```bash
npx @redocly/cli lint openapi/openapi.yaml
```

### Code Generation

Generate client SDKs:

```bash
npx @openapitools/openapi-generator-cli generate \
  -i openapi/openapi.yaml \
  -g typescript-axios \
  -o sdk/
```

## Related Workflows

- [`docs-api.yml`](../workflows/docs-api.yml) - Generate and deploy API documentation

## Resources

- [OpenAPI 3.1 Specification](https://spec.openapis.org/oas/v3.1.0)
- [Redocly CLI](https://redocly.com/docs/cli/)
- [OpenAPI Generator](https://openapi-generator.tech/)
- [Swagger Editor](https://editor.swagger.io/)
