// Commitlint Configuration
// Enforces Conventional Commits specification
// https://www.conventionalcommits.org/

module.exports = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    // Type must be one of the following
    'type-enum': [
      2,
      'always',
      [
        'feat',     // New feature
        'fix',      // Bug fix
        'docs',     // Documentation only changes
        'style',    // Changes that don't affect meaning (formatting, etc.)
        'refactor', // Code change that neither fixes a bug nor adds a feature
        'perf',     // Performance improvement
        'test',     // Adding or correcting tests
        'build',    // Changes to build system or dependencies
        'ci',       // Changes to CI configuration
        'chore',    // Other changes that don't modify src or test files
        'revert',   // Reverts a previous commit
      ],
    ],
    // Subject must not be empty
    'subject-empty': [2, 'never'],
    // Subject must not end with period
    'subject-full-stop': [2, 'never', '.'],
    // Subject case: allow lowercase and sentence-case
    'subject-case': [
      2,
      'never',
      ['start-case', 'pascal-case', 'upper-case'],
    ],
    // Type must not be empty
    'type-empty': [2, 'never'],
    // Type case: lowercase
    'type-case': [2, 'always', 'lower-case'],
    // Header max length: 100 characters
    'header-max-length': [2, 'always', 100],
    // Body max line length: 100 characters
    'body-max-line-length': [2, 'always', 100],
  },
};
