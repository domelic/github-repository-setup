# Pull Request Review Guidelines

This document outlines our standards for reviewing pull requests.

## Review Checklist

When reviewing a PR, consider the following:

### Code Quality

- [ ] Code is readable and well-organized
- [ ] Variable and function names are descriptive
- [ ] No unnecessary code duplication
- [ ] Follows existing project patterns and conventions

### Documentation

- [ ] Changes are documented where necessary
- [ ] README updated if user-facing behavior changes
- [ ] Comments explain non-obvious logic

### Testing

- [ ] Changes work as described
- [ ] Edge cases are considered
- [ ] No regressions introduced

### Security

- [ ] No sensitive data exposed
- [ ] Input validation where appropriate
- [ ] Dependencies are from trusted sources

## Approval Requirements

| Change Type | Required Approvals |
|-------------|-------------------|
| Documentation only | 0 (auto-merge OK) |
| Minor changes | 1 |
| Feature additions | 1 |
| Breaking changes | 2 |

## Response Time Expectations

- Initial review within 2 business days
- Follow-up responses within 1 business day
- If unavailable, communicate delays

## Providing Feedback

### Do

- Be specific about what needs to change
- Explain the reasoning behind suggestions
- Acknowledge good work
- Offer alternatives when requesting changes

### Avoid

- Vague comments like "fix this"
- Nitpicking style when not in guidelines
- Blocking on personal preferences
- Leaving reviews incomplete

## Handling Disagreements

1. Discuss in PR comments first
2. If unresolved, bring in another maintainer
3. Final decision rests with code owners
4. Document decisions for future reference

## Merging

- Ensure all CI checks pass
- Use squash merge for clean history
- Delete branch after merge (automatic)
- Verify the merge commit message is clear
