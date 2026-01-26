# GitHub Copilot Instructions

> Repository-specific instructions for GitHub Copilot to generate code that matches your project's conventions.

## Project Context

<!-- Describe your project in 2-3 sentences -->
This is a [PROJECT_TYPE] application built with [TECH_STACK].
The codebase follows [ARCHITECTURE_PATTERN] architecture.

## Coding Standards

### Language & Framework

- **Primary language:** [JavaScript/TypeScript/Python/Go/Rust/etc.]
- **Framework:** [React/Vue/Django/FastAPI/Gin/etc.]
- **Package manager:** [npm/yarn/pnpm/pip/cargo/go modules]

### Style Guidelines

- Use [tabs/2 spaces/4 spaces] for indentation
- Maximum line length: [80/100/120] characters
- Quote style: [single/double] quotes for strings
- Semicolons: [always/never] (for JS/TS)
- Trailing commas: [always/never/es5]

### Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| Variables | camelCase | `userName`, `itemCount` |
| Functions | camelCase | `getUserById`, `calculateTotal` |
| Classes | PascalCase | `UserService`, `DatabaseConnection` |
| Constants | SCREAMING_SNAKE_CASE | `MAX_RETRIES`, `API_BASE_URL` |
| Files | kebab-case | `user-service.ts`, `api-client.js` |
| Components | PascalCase | `UserProfile.tsx`, `NavBar.vue` |

## Architecture

### Project Structure

```text
src/
├── components/    # Reusable UI components
├── pages/         # Page/route components
├── services/      # Business logic & API calls
├── utils/         # Utility functions
├── types/         # TypeScript type definitions
├── hooks/         # Custom React hooks (if applicable)
└── tests/         # Test files
```

### Key Patterns

- **State management:** [Redux/Zustand/Context/Pinia/etc.]
- **API calls:** Use [fetch/axios/ky] with [service pattern/hooks]
- **Error handling:** [try-catch/Result type/Error boundaries]
- **Logging:** Use [console/winston/pino] with structured logs

## Testing

### Testing Framework

- Unit tests: [Jest/Vitest/pytest/go test]
- Integration tests: [Supertest/pytest/httptest]
- E2E tests: [Playwright/Cypress/none]

### Test Conventions

- Test files: `*.test.ts` or `*.spec.ts` alongside source files
- Use descriptive test names: `should return user when valid ID provided`
- Follow AAA pattern: Arrange, Act, Assert
- Mock external dependencies, don't mock internal modules

### Coverage Requirements

- Minimum coverage: [70%/80%/90%]
- Critical paths must have [unit/integration] tests

## Security

### Authentication & Authorization

- Auth method: [JWT/OAuth/Session/API keys]
- Protected routes use [middleware/guards/decorators]

### Input Validation

- Always validate user input using [Zod/Joi/Pydantic/validator]
- Sanitize data before database operations
- Use parameterized queries for SQL

### Sensitive Data

- Never hardcode secrets, credentials, or API keys
- Use environment variables via [dotenv/.env/secrets manager]
- Never log sensitive information (passwords, tokens, PII)

## Do Not (Anti-Patterns)

When generating code, **avoid** these patterns:

1. **Don't use `any` type** in TypeScript—use proper types or `unknown`
2. **Don't use `var`**—use `const` by default, `let` when reassignment is needed
3. **Don't ignore errors**—always handle or propagate them
4. **Don't use magic numbers**—extract to named constants
5. **Don't mutate function parameters**—return new values instead
6. **Don't use synchronous file operations**—prefer async/await
7. **Don't commit commented-out code**—remove or use feature flags
8. **Don't use `==`**—always use `===` for comparisons (JS/TS)

## Examples

### Good Code Pattern

```typescript
// ✅ Good: Typed, async, error handling, named constants
const MAX_RETRIES = 3;

async function fetchUser(id: string): Promise<User | null> {
  try {
    const response = await api.get<User>(`/users/${id}`);
    return response.data;
  } catch (error) {
    logger.error('Failed to fetch user', { id, error });
    return null;
  }
}
```

### Bad Code Pattern

```typescript
// ❌ Bad: Untyped, sync, no error handling, magic number
function fetchUser(id) {
  var user = api.get('/users/' + id);
  if (user.retries > 3) {
    // console.log('too many retries');
  }
  return user;
}
```

## Dependencies

### Preferred Libraries

| Purpose | Library | Notes |
|---------|---------|-------|
| HTTP client | [axios/fetch/ky] | |
| Date handling | [date-fns/dayjs] | Not moment.js |
| Validation | [Zod/Joi/Yup] | |
| State | [Zustand/Redux Toolkit] | |
| Styling | [Tailwind/CSS Modules] | |

### Avoid These Libraries

- `moment.js` — use `date-fns` or `dayjs` instead
- `lodash` — use native methods when possible
- `request` — deprecated, use `fetch` or `axios`

## API Conventions

### REST Endpoints

- Use plural nouns: `/users`, `/products`
- Use HTTP verbs correctly: GET (read), POST (create), PUT/PATCH (update), DELETE
- Return appropriate status codes: 200, 201, 400, 401, 403, 404, 500

### Response Format

```json
{
  "data": { ... },
  "meta": {
    "page": 1,
    "total": 100
  },
  "error": null
}
```

## Additional Context

<!-- Add any project-specific instructions -->
- [Custom instructions specific to your project]
- [Team conventions not covered above]
- [Integration requirements with external systems]

---

*This file is read by GitHub Copilot to provide repository-specific suggestions. Keep it updated as your project evolves.*
