# OpenTelemetry Templates

This directory contains starter configurations for OpenTelemetry observability.

## Overview

OpenTelemetry provides a standardized way to collect and export telemetry data (traces, metrics, logs) from your applications.

## Files

| File | Description |
|------|-------------|
| `otel-collector-config.yaml` | OpenTelemetry Collector configuration |
| `docker-compose.otel.yaml` | Local observability stack with Jaeger, Prometheus, Grafana |

## Quick Start

### 1. Start the Observability Stack

```bash
docker-compose -f docker-compose.otel.yaml up -d
```

### 2. Access the UIs

| Service | URL | Credentials |
|---------|-----|-------------|
| Jaeger | http://localhost:16686 | - |
| Prometheus | http://localhost:9090 | - |
| Grafana | http://localhost:3000 | admin/admin |
| Collector Health | http://localhost:13133 | - |

### 3. Configure Your Application

#### Node.js

```bash
npm install @opentelemetry/sdk-node @opentelemetry/auto-instrumentations-node
```

```javascript
// tracing.js
const { NodeSDK } = require('@opentelemetry/sdk-node');
const { getNodeAutoInstrumentations } = require('@opentelemetry/auto-instrumentations-node');
const { OTLPTraceExporter } = require('@opentelemetry/exporter-trace-otlp-grpc');

const sdk = new NodeSDK({
  serviceName: process.env.OTEL_SERVICE_NAME || 'my-service',
  traceExporter: new OTLPTraceExporter({
    url: process.env.OTEL_EXPORTER_OTLP_ENDPOINT || 'http://localhost:4317',
  }),
  instrumentations: [getNodeAutoInstrumentations()],
});

sdk.start();
```

```javascript
// app.js
require('./tracing');
// ... rest of your application
```

#### Python

```bash
pip install opentelemetry-distro opentelemetry-exporter-otlp
opentelemetry-bootstrap -a install
```

```python
# tracing.py
from opentelemetry import trace
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor
from opentelemetry.exporter.otlp.proto.grpc.trace_exporter import OTLPSpanExporter
from opentelemetry.sdk.resources import Resource

resource = Resource.create({
    "service.name": os.getenv("OTEL_SERVICE_NAME", "my-service"),
})

provider = TracerProvider(resource=resource)
processor = BatchSpanProcessor(OTLPSpanExporter(
    endpoint=os.getenv("OTEL_EXPORTER_OTLP_ENDPOINT", "http://localhost:4317"),
))
provider.add_span_processor(processor)
trace.set_tracer_provider(provider)
```

#### Go

```bash
go get go.opentelemetry.io/otel
go get go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracegrpc
```

```go
package main

import (
    "go.opentelemetry.io/otel"
    "go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracegrpc"
    "go.opentelemetry.io/otel/sdk/trace"
)

func initTracer() func() {
    exporter, _ := otlptracegrpc.New(context.Background(),
        otlptracegrpc.WithEndpoint("localhost:4317"),
        otlptracegrpc.WithInsecure(),
    )

    tp := trace.NewTracerProvider(
        trace.WithBatcher(exporter),
        trace.WithResource(resource.NewWithAttributes(
            semconv.ServiceNameKey.String("my-service"),
        )),
    )

    otel.SetTracerProvider(tp)

    return func() { tp.Shutdown(context.Background()) }
}
```

## Environment Variables

Standard OpenTelemetry environment variables:

| Variable | Description | Example |
|----------|-------------|---------|
| `OTEL_SERVICE_NAME` | Service name | `my-service` |
| `OTEL_EXPORTER_OTLP_ENDPOINT` | Collector endpoint | `http://localhost:4317` |
| `OTEL_TRACES_SAMPLER` | Sampling strategy | `parentbased_traceidratio` |
| `OTEL_TRACES_SAMPLER_ARG` | Sampler argument | `0.1` (10% sampling) |
| `OTEL_PROPAGATORS` | Context propagators | `tracecontext,baggage` |
| `OTEL_LOG_LEVEL` | SDK log level | `debug` |

## Production Considerations

### Sampling

For production, configure sampling to reduce data volume:

```yaml
processors:
  probabilistic_sampler:
    sampling_percentage: 10  # Sample 10% of traces
```

### Security

1. Use TLS for the collector endpoint
2. Configure authentication headers
3. Don't expose collector ports publicly

### Backends

Popular OpenTelemetry-compatible backends:

| Backend | Type | Notes |
|---------|------|-------|
| Jaeger | Traces | Open source, CNCF project |
| Zipkin | Traces | Open source, lightweight |
| Prometheus | Metrics | Open source, CNCF project |
| Grafana Tempo | Traces | Works with Grafana |
| Grafana Loki | Logs | Works with Grafana |
| Honeycomb | All | Commercial, excellent UX |
| Datadog | All | Commercial, full platform |
| New Relic | All | Commercial, full platform |
| Dynatrace | All | Commercial, AI-powered |

## Related Resources

- [OpenTelemetry Documentation](https://opentelemetry.io/docs/)
- [Collector Configuration](https://opentelemetry.io/docs/collector/configuration/)
- [Instrumentation Libraries](https://opentelemetry.io/docs/instrumentation/)
