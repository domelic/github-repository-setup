import { defineConfig } from 'vitest/config';

export default defineConfig({
  test: {
    // Test environment
    environment: 'node', // or 'jsdom', 'happy-dom'

    // Include patterns
    include: ['**/*.{test,spec}.{js,mjs,cjs,ts,mts,cts,jsx,tsx}'],

    // Exclude patterns
    exclude: ['**/node_modules/**', '**/dist/**', '**/e2e/**'],

    // Coverage configuration
    coverage: {
      provider: 'v8', // or 'istanbul'
      reporter: ['text', 'json', 'html', 'lcov'],
      reportsDirectory: './coverage',
      exclude: [
        'node_modules/',
        'dist/',
        '**/*.d.ts',
        '**/*.test.{js,ts}',
        '**/*.spec.{js,ts}',
        '**/tests/**',
        '**/__tests__/**',
        '**/__mocks__/**',
      ],
      thresholds: {
        lines: 80,
        functions: 80,
        branches: 80,
        statements: 80,
      },
    },

    // Global setup/teardown
    // globalSetup: './tests/global-setup.ts',
    // globalTeardown: './tests/global-teardown.ts',

    // Setup files run before each test file
    // setupFiles: ['./tests/setup.ts'],

    // Reporters
    reporters: ['default'],

    // Watch mode configuration
    watch: false,

    // Globals (like describe, it, expect)
    globals: true,

    // Type checking
    typecheck: {
      enabled: false,
      include: ['**/*.{test,spec}-d.{ts,tsx}'],
    },

    // Pool options for parallel execution
    pool: 'threads',
    poolOptions: {
      threads: {
        singleThread: false,
      },
    },

    // Timeout per test
    testTimeout: 10000,

    // Retry failed tests
    retry: 0,

    // Snapshot configuration
    snapshotFormat: {
      escapeString: false,
      printBasicPrototype: false,
    },
  },

  // Resolve aliases (if using path aliases)
  // resolve: {
  //   alias: {
  //     '@': '/src',
  //   },
  // },
});
