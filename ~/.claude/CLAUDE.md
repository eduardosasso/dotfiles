# Global Development Conventions

These are my default preferences. Project-specific CLAUDE.md files may override or extend these.

## Code Style

### TypeScript
- Explicit type annotations for all variables, parameters, and return values
- Never use `any` - use `unknown` for truly unknown types
- Always use arrow functions, not `function` keyword
- Use `const` by default, `let` only when reassignment is needed

### Naming
- Prefer single-word names when possible (multi-word suggests unclear thinking)
- Use domain language over technical descriptions
- No getter/setter prefixes (`get`, `set`, `do`, `handle`, `is`, `has`)
- Examples: `User.find()`, `Trip.current()`, `Article.publish()`
- camelCase for variables and functions
- PascalCase for types and classes
- SCREAMING_SNAKE_CASE for constants

### Imports
- Always use path aliases (`@/` or `~/`) for local imports, never relative paths (`../`)
- Namespace imports for models: `import * as User from "@/models/user"`
- Group imports: external libraries first, then local modules

### Functional Programming
- Prefer `map`, `filter`, `reduce`, `flatMap` over if-else chains
- Maximum one level of nesting for conditionals
- No nested ternaries
- Inline single-statement conditionals:
  ```typescript
  if (!user) throw new Error("User not found");
  if (done) return result;
  ```

### Formatting
- 2-space indentation
- Empty line before return statements
- Each SQL column on its own line in SELECT statements

## File Organization

- Singular filenames for models: `user.ts` not `users.ts`
- Keep files focused and small
- Prefer editing existing files over creating new ones
- Export types as `Record` for database models

## Testing

- Write tests for all new functionality
- Concise test names: "user creation", "returns 404 for missing"
- No magic numbers - use SCREAMING_SNAKE_CASE constants
- Integration tests use `.integration.test.ts` suffix

## Git

### Commits
- Short, descriptive commit messages
- No prefixes (avoid "feat:", "fix:", "chore:")
- Focus on what the commit accomplishes, not the type of change
- Examples:
  - Good: "user authentication with passkeys"
  - Bad: "feat: add user authentication feature"

### Pre-commit
Always run before committing:
1. Lint/format check
2. Type check
3. Tests

## General Principles

- Avoid over-engineering - only make changes directly requested
- Don't add features, refactoring, or "improvements" beyond what's asked
- Keep solutions simple and focused
- Don't add comments unless logic isn't self-evident
- Semantic HTML with minimal CSS classes
- Prefer existing patterns in the codebase
