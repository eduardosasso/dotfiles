# Global Development Conventions

Project-specific CLAUDE.md files may override these defaults.

## IMPORTANT

- ALWAYS run lint and type-check before suggesting code is complete
- NEVER use `any` type - use `unknown` if truly unknown
- NEVER manually format code - use the project's linter
- NEVER add features or refactoring beyond what's asked

## Preferred Stack (New Projects)

- **Runtime**: Bun (use `bun` not `npm`/`yarn`)
- **Linter/Formatter**: Biome
- **Database**: SQLite (`bun:sqlite`)

## Commands

Check the project's `package.json`, but typically:
- **Lint**: `bun lint` or `npm run check`
- **Type check**: `bun check` or `npm run type-check`
- **Test**: `bun test` or `npm test`
- **Dev**: `bun dev` or `npm run dev`

## TypeScript

- Explicit type annotations for variables, parameters, return values
- Arrow functions only, not `function` keyword
- `const` by default, `let` only when reassignment needed
- Path aliases (`@/` or `~/`) for imports, never relative (`../`)
- Namespace imports for models: `import * as User from "@/models/user"`

## Naming

- Single-word names when possible
- Domain language over technical jargon
- No prefixes: `get`, `set`, `do`, `handle`, `is`, `has`
- Examples: `User.find()`, `Trip.current()`, `Article.publish()`
- camelCase (variables/functions), PascalCase (types), SCREAMING_SNAKE (constants)

## Code Style

- Functional: prefer `map`, `filter`, `reduce` over if-else
- Max one level of conditional nesting
- Inline single-statement conditionals: `if (!user) throw new Error("Not found");`
- 2-space indentation, empty line before return
- Singular filenames: `user.ts` not `users.ts`

## Testing

- Tests for all new functionality
- Concise names: "user creation", "returns 404"
- No magic numbers - use SCREAMING_SNAKE constants
- Integration tests: `.integration.test.ts`

## Git

- Short commit messages, no prefixes (no "feat:", "fix:")
- Good: "user authentication with passkeys"
- Bad: "feat: add user authentication feature"
- Run lint → type-check → tests before committing

## Gotchas

- Don't add comments unless logic isn't self-evident
- Don't create new files if editing existing ones works
- Prefer pointers to code snippets in docs (they go stale)
- Semantic HTML with minimal CSS classes
- Follow existing patterns in the codebase
