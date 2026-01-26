# Feature Flags Guide

Feature flags (also called feature toggles) allow you to modify system behavior without changing code. This guide covers implementation patterns and popular platforms.

## Why Use Feature Flags?

| Use Case | Description |
|----------|-------------|
| **Gradual Rollouts** | Release features to a percentage of users |
| **A/B Testing** | Compare different implementations |
| **Kill Switches** | Quickly disable problematic features |
| **Trunk-Based Development** | Merge incomplete features safely |
| **Environment-Specific** | Different behavior per environment |
| **User Segmentation** | Target specific user groups |

## Implementation Patterns

### Simple Boolean Flag

```javascript
// Basic on/off toggle
if (featureFlags.isEnabled('new-dashboard')) {
  return <NewDashboard />;
}
return <OldDashboard />;
```

### Percentage Rollout

```javascript
// Roll out to 10% of users
if (featureFlags.getVariation('new-checkout', user) === 'enabled') {
  return <NewCheckout />;
}
return <OldCheckout />;
```

### User Targeting

```javascript
// Target specific users or groups
const flags = featureFlags.getFlags(user);
if (flags['beta-features']) {
  showBetaFeatures();
}
```

## Platform Comparison

| Platform | Free Tier | Self-Hosted | Best For |
|----------|-----------|-------------|----------|
| LaunchDarkly | Limited | No | Enterprise |
| Flagsmith | Yes | Yes | Self-hosted |
| Unleash | Yes | Yes | Open source |
| Split | Yes | No | Product teams |
| ConfigCat | Yes | No | Simple needs |
| Flipt | Yes | Yes | Open source |

## LaunchDarkly Integration

### Setup

```bash
npm install launchdarkly-node-server-sdk
# or
npm install launchdarkly-js-client-sdk
```

### Server-Side (Node.js)

```javascript
const LaunchDarkly = require('launchdarkly-node-server-sdk');

const client = LaunchDarkly.init(process.env.LAUNCHDARKLY_SDK_KEY);

await client.waitForInitialization();

// Check flag value
const user = {
  key: 'user-123',
  email: 'user@example.com',
  custom: {
    plan: 'premium',
    company: 'acme',
  },
};

const showFeature = await client.variation('new-feature', user, false);

if (showFeature) {
  // Feature is enabled for this user
}
```

### Client-Side (React)

```javascript
import { LDProvider, useFlags } from 'launchdarkly-react-client-sdk';

// Wrap your app
function App() {
  return (
    <LDProvider clientSideID={process.env.REACT_APP_LD_CLIENT_ID}>
      <MyApp />
    </LDProvider>
  );
}

// Use flags in components
function Dashboard() {
  const { newDashboard } = useFlags();

  return newDashboard ? <NewDashboard /> : <OldDashboard />;
}
```

### GitHub Actions Integration

```yaml
name: Feature Flag Check

on:
  pull_request:
    branches: [main]

jobs:
  check-flags:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Check for stale flags
        run: |
          # Search for flag references
          grep -r "featureFlags\|useFlags\|variation" src/ || true

      - name: Validate flag configuration
        env:
          LD_API_KEY: ${{ secrets.LAUNCHDARKLY_API_KEY }}
        run: |
          # Use LaunchDarkly API to validate flags exist
          curl -s -H "Authorization: $LD_API_KEY" \
            "https://app.launchdarkly.com/api/v2/flags/default" \
            | jq '.items[].key'
```

## Flagsmith Integration

### Self-Hosted Setup

```yaml
# docker-compose.yml
services:
  flagsmith:
    image: flagsmith/flagsmith:latest
    ports:
      - "8000:8000"
    environment:
      - DATABASE_URL=postgresql://postgres:password@db:5432/flagsmith
      - DJANGO_SECRET_KEY=your-secret-key
    depends_on:
      - db

  db:
    image: postgres:15-alpine
    environment:
      - POSTGRES_PASSWORD=password
      - POSTGRES_DB=flagsmith
    volumes:
      - flagsmith_data:/var/lib/postgresql/data

volumes:
  flagsmith_data:
```

### Client Integration

```javascript
import Flagsmith from 'flagsmith';

const flagsmith = new Flagsmith({
  environmentKey: process.env.FLAGSMITH_ENVIRONMENT_KEY,
});

await flagsmith.init({
  identity: 'user-123',
  traits: {
    email: 'user@example.com',
    plan: 'premium',
  },
});

if (flagsmith.hasFeature('new-feature')) {
  // Feature enabled
}

// Get feature value
const limit = flagsmith.getValue('api-rate-limit', 100);
```

## Environment-Based Flags

### Simple Implementation

```javascript
// config/features.js
const features = {
  development: {
    debugMode: true,
    experimentalApi: true,
    mockPayments: true,
  },
  staging: {
    debugMode: true,
    experimentalApi: true,
    mockPayments: false,
  },
  production: {
    debugMode: false,
    experimentalApi: false,
    mockPayments: false,
  },
};

export const getFeatures = () => features[process.env.NODE_ENV] || features.development;
```

### With Environment Variables

```bash
# .env.development
FEATURE_DEBUG_MODE=true
FEATURE_EXPERIMENTAL_API=true

# .env.production
FEATURE_DEBUG_MODE=false
FEATURE_EXPERIMENTAL_API=false
```

```javascript
const features = {
  debugMode: process.env.FEATURE_DEBUG_MODE === 'true',
  experimentalApi: process.env.FEATURE_EXPERIMENTAL_API === 'true',
};
```

## Testing Strategies

### Unit Testing

```javascript
// Mock the feature flag service
jest.mock('./featureFlags', () => ({
  isEnabled: jest.fn(),
}));

import { isEnabled } from './featureFlags';

describe('Dashboard', () => {
  it('renders new dashboard when flag is enabled', () => {
    isEnabled.mockReturnValue(true);
    render(<Dashboard />);
    expect(screen.getByTestId('new-dashboard')).toBeInTheDocument();
  });

  it('renders old dashboard when flag is disabled', () => {
    isEnabled.mockReturnValue(false);
    render(<Dashboard />);
    expect(screen.getByTestId('old-dashboard')).toBeInTheDocument();
  });
});
```

### Integration Testing

```javascript
// Test both paths in CI
describe('Feature: New Checkout', () => {
  it('works with new checkout enabled', async () => {
    process.env.FEATURE_NEW_CHECKOUT = 'true';
    // Test new checkout flow
  });

  it('works with new checkout disabled', async () => {
    process.env.FEATURE_NEW_CHECKOUT = 'false';
    // Test old checkout flow
  });
});
```

## Best Practices

### 1. Flag Naming Convention

```text
# Format: <scope>-<feature>-<variant>
# Examples:
ui-dark-mode
checkout-new-flow
api-v2-endpoints
experiment-pricing-page-b
```

### 2. Flag Lifecycle

```text
1. Create flag (default: off)
2. Implement feature behind flag
3. Merge to main
4. Test in staging
5. Gradual rollout (10% → 50% → 100%)
6. Monitor metrics
7. Remove flag after stable (within 30 days)
```

### 3. Flag Cleanup

```yaml
# .github/workflows/stale-flags.yml
name: Check Stale Flags

on:
  schedule:
    - cron: '0 9 * * 1'  # Weekly

jobs:
  check-flags:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Find old flag references
        run: |
          # Find flags older than 30 days
          # Alert on Slack/create issues
```

### 4. Documentation

Document flags in code:

```javascript
/**
 * @flag new-search-algorithm
 * @owner search-team
 * @created 2024-01-15
 * @expires 2024-03-15
 * @description Enables the new ML-based search ranking
 */
if (flags.isEnabled('new-search-algorithm')) {
  return newSearch(query);
}
```

## Monitoring

### Track Flag Usage

```javascript
// Log flag evaluations for debugging
client.on('flag-change', (key, value) => {
  analytics.track('flag_evaluated', {
    flag: key,
    value: value,
    userId: user.id,
  });
});
```

### Metrics to Watch

- **Flag evaluation count** - Ensure flags are being evaluated
- **Error rates by flag state** - Catch issues early
- **Performance by flag state** - Compare old vs new
- **Conversion by flag state** - A/B test results

## Related Resources

- [Branching Strategies](../guides/BRANCHING_STRATEGIES.md) - Trunk-based development with flags
- [LaunchDarkly Docs](https://docs.launchdarkly.com/)
- [Flagsmith Docs](https://docs.flagsmith.com/)
- [Martin Fowler on Feature Toggles](https://martinfowler.com/articles/feature-toggles.html)
