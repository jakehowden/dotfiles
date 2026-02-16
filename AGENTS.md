# AGENTS.md

> AI coding assistant instructions for this workspace.
> Compatible with GitHub Copilot, Cursor, Claude Code, and other AI tools that read AGENTS.md.
>
> This is a living document — refine it over time as conventions solidify.

---

## About Me

- **Role:** Senior Software Developer
- **Domain:** Backend services, event-driven architectures, API development
- **Responsibilities:** Writing production code, technical documentation, ADRs, user stories, and code reviews

---

## Tech Stack

| Area | Technologies |
|---|---|
| Language | C# / .NET (latest LTS preferred) |
| Messaging | Kafka (actively migrating to **Azure Service Bus**) |
| APIs | **Minimal APIs**, **Refit** (typed HTTP clients) |
| Testing | **xUnit** (unit & integration tests) |
| Cloud | Azure |
| OS / Tooling | macOS, yabai (tiling WM), zsh |

---

## Code Guidelines

### General

- Write **production-grade** code — no placeholders, no TODOs unless explicitly asked.
- Favour **clarity over cleverness**. Code is read far more than it is written.
- Keep methods small and focused. Prefer composition over inheritance.
- Use meaningful names — avoid abbreviations unless they are domain-standard (e.g. `DTO`, `API`).

### C# / .NET Specifics

- Target the latest stable .NET LTS release unless otherwise stated.
- Use **file-scoped namespaces**.
- Prefer `record` types for DTOs and value objects.
- Use `IOptions<T>` / `IOptionsSnapshot<T>` for configuration binding.
- Prefer `async/await` throughout — avoid `.Result` or `.Wait()`.
- Register dependencies via extension methods (e.g. `AddMyFeature()`).

### Event-Driven / Messaging

- Consumers and producers should be thin — delegate business logic to dedicated services.
- Design messages as immutable contracts. Use versioning when schemas change.
- When writing Azure Service Bus code, follow the `ServiceBusClient` / `ServiceBusProcessor` patterns.
- For Kafka code, follow existing consumer/producer patterns in the codebase.

### APIs

- Use **Minimal API** style with endpoint grouping via `MapGroup()`.
- Use **Refit** for outbound HTTP clients — define interfaces, not manual `HttpClient` calls.
- Return `Results.Ok()`, `Results.NotFound()`, etc. — avoid throwing exceptions for control flow.
- Validate inputs with FluentValidation or endpoint filters where appropriate.

### Testing

- **Framework:** xUnit for all tests.
- Follow **Arrange / Act / Assert** structure.
- Use descriptive test names: `MethodName_Scenario_ExpectedResult`.
- Prefer `NSubstitute` or `Moq` for mocking — stay consistent within a project.
- Aim for meaningful coverage, not 100% line coverage.

---

## Documentation & Writing

When I ask for help with documentation, follow these guidelines:

### ADRs (Architecture Decision Records)

Use this structure:
1. **Title** — Short, descriptive
2. **Status** — Proposed / Accepted / Deprecated / Superseded
3. **Context** — What is the problem or situation?
4. **Decision** — What did we decide and why?
5. **Consequences** — What are the trade-offs?

### User Stories

Use the standard format:
> As a [persona], I want [goal], so that [benefit].

Include **acceptance criteria** as a checklist. Keep stories small and independently deliverable.

### General Technical Docs

- Write in plain English. Avoid jargon unless the audience is technical.
- Use diagrams (Mermaid) where they add clarity.
- Structure with clear headings, short paragraphs, and bullet points.

---

## AI Behaviour Preferences

- **Be direct.** Skip preamble — get to the answer or code.
- **Show complete files/methods** when making changes — don't use `// ... existing code` shorthand unless the file is very large.
- **Explain trade-offs** when there are multiple reasonable approaches.
- **Ask before assuming** if a requirement is genuinely ambiguous — but prefer a sensible default over excessive questions.
- **Don't over-comment** code. Let good naming and structure speak for itself. Add comments only where *why* is non-obvious.
- When generating multiple files, maintain consistency in style and structure across all of them.

---

## Sections To Expand Later

> These are placeholders for conventions I'll define as my projects mature.

- [ ] Architecture patterns (Clean Architecture, Vertical Slices, etc.)
- [ ] Naming conventions (projects, namespaces, folders)
- [ ] Error handling strategy
- [ ] Logging & observability standards
- [ ] CI/CD pipeline conventions
- [ ] Git branching and commit message conventions
- [ ] Infrastructure as Code preferences (Bicep / Terraform)
