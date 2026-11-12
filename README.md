# OpenPrime Keycloak

Keycloak identity and access management for the OpenPrime infrastructure platform.

## Overview

This repository contains:
- Custom Keycloak Docker image with OpenPrime theme
- Helm chart for Kubernetes deployment

## Components

### Docker Image

Based on `quay.io/keycloak/keycloak:26.8.1` with:
- OpenPrime custom theme pre-installed
- Production-ready configuration

### Helm Chart

Deploy Keycloak to Kubernetes with customizable values. The chart refuses to render without the database and bootstrap-admin passwords, and refuses a password given as a plain `app.env` value; pass them from a Secret:

```bash
kubectl create secret generic keycloak-secrets \
  --from-literal=KC_DB_PASSWORD=... --from-literal=KC_BOOTSTRAP_ADMIN_PASSWORD=...
helm install openprime-keycloak ./chart \
  --set app.existingSecret=keycloak-secrets \
  --set 'app.existingSecretKeys={KC_DB_PASSWORD,KC_BOOTSTRAP_ADMIN_PASSWORD}'
```

`app.secrets` (the chart then creates the Secret) works too. `keycloak.devMode: true` (local `start-dev`) skips the password requirement.

## Configuration

See `chart/values.yaml` for all available configuration options.

### Key Settings

| Parameter | Description | Default |
|-----------|-------------|---------|
| `replicaCount` | Number of replicas | `1` |
| `image.repository` | Keycloak image | `ghcr.io/devopsgroupeu/openprime-keycloak` |
| `image.tag` | Image tag | `latest` |
| `realmSetup.enabled` | Enable realm auto-configuration | `true` |
| `app.existingSecret` | Secret holding the keys listed in `app.existingSecretKeys` (`KC_DB_PASSWORD` and `KC_BOOTSTRAP_ADMIN_PASSWORD` are required) | `""` |
| `app.secrets` | Alternative: values the chart puts into its own Secret | `{}` |
| `app.env.KC_BOOTSTRAP_ADMIN_USERNAME` | Bootstrap admin user | `admin` |
| `updateStrategy` | `RollingUpdate`, or `Recreate` for a Keycloak minor upgrade | `RollingUpdate` |
| `openprime.realm.identityProviders.google.enabled` | Sign in with Google, see below | `false` |
| `openprime.realm.identityProviders.google.clientId` | Google OAuth client ID | `""` |
| `openprime.realm.identityProviders.google.clientSecretKey` | Key in the Secret that holds the client secret | `GOOGLE_CLIENT_SECRET` |

### Sign in with Google

1. In Google Cloud, configure the OAuth consent screen (scopes `openid`, `email`, `profile`) and create an OAuth client of type **Web application** with the authorized redirect URI `https://<KC_HOSTNAME>/realms/openprime/broker/google/endpoint`. While the consent screen is in *Testing*, only its listed test users can sign in.
2. Put the client secret into the chart's Secret under `GOOGLE_CLIENT_SECRET`: a key in `app.existingSecret` (for an External Secret, add the key to its `data`), or `app.secrets`.
3. Set `openprime.realm.identityProviders.google.enabled: true` and `clientId`.

The realm-setup Job creates or updates the provider on every deploy, so a rotated client secret takes effect on the next deploy. Setting `enabled: false` disables the provider but keeps it, so users keep their link to Google; it is never deleted.

How it behaves:

- Emails from Google are trusted (`trustEmail`), so a new Google user gets no verification mail. A user whose Google account has no family name is asked for one once, because the realm requires it.
- If an account with the same email already exists, Keycloak's default first-login flow asks the user to confirm the link through a mail sent to that address. Known and accepted risk: someone who registered that address earlier without owning it, and knows the password they set, keeps access to the account the owner then links.
- Keycloak exchanges the code with Google itself, so with `networkPolicy.enabled` its egress must allow DNS and HTTPS to the internet.

### Upgrading Keycloak

A minor upgrade (for example 26.2 to 26.8) migrates the database one way, and the old and new versions must not run against it at the same time. Back up the database first: rolling back means restoring that backup together with the old image. Sync the upgrade with `updateStrategy: Recreate`, which stops every pod before the new ones start, then set it back to `RollingUpdate`.

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
