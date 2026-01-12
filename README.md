# OpenPrime Keycloak

Keycloak identity and access management for the OpenPrime infrastructure platform.

## Overview

This repository contains:
- Custom Keycloak Docker image with OpenPrime theme
- Helm chart for Kubernetes deployment

## Components

### Docker Image

Based on `quay.io/keycloak/keycloak:26.2.0` with:
- OpenPrime custom theme pre-installed
- Production-ready configuration

### Helm Chart

Deploy Keycloak to Kubernetes with customizable values:

```bash
helm install openprime-keycloak ./chart
```

## Configuration

See `chart/values.yaml` for all available configuration options.

### Key Settings

| Parameter | Description | Default |
|-----------|-------------|---------|
| `replicaCount` | Number of replicas | `1` |
| `image.repository` | Keycloak image | `ghcr.io/devopsgroupeu/openprime-keycloak` |
| `image.tag` | Image tag | `latest` |
| `realmSetup.enabled` | Enable realm auto-configuration | `true` |

## Development

### Build Docker Image

```bash
docker build -t openprime-keycloak .
```

### Local Development

Use the main development environment from `openprime-local-testing`:

```bash
cd ../openprime-local-testing
npm start
```

Keycloak will be available at http://localhost:8080

## Related Repositories

- [openprime-app](https://github.com/devopsgroupeu/openprime-app) - Frontend application
- [openprime-app-backend](https://github.com/devopsgroupeu/openprime-app-backend) - Backend API
- [openprime-local-testing](https://github.com/devopsgroupeu/openprime-local-testing) - Development environment

## License

Apache License 2.0 - see [LICENSE](LICENSE) for details.
