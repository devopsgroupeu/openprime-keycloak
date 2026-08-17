# Changelog

All notable changes to this project will be documented in this file.

## [0.9.3](https://github.com/devopsgroupeu/openprime-keycloak/compare/v0.9.2...v0.9.3) (2026-08-17)

### ⚡ Performance Improvements

* **docker:** run kc.sh build at image build time (OP-173 step 7) ([#14](https://github.com/devopsgroupeu/openprime-keycloak/issues/14)) ([5b349f2](https://github.com/devopsgroupeu/openprime-keycloak/commit/5b349f28fe66e84bee00a6c565911154dfa714ef))

## [0.9.2](https://github.com/devopsgroupeu/openprime-keycloak/compare/v0.9.1...v0.9.2) (2026-08-13)

### 🐛 Bug Fixes

* **chart:** probe something that fails when keycloak is broken ([#13](https://github.com/devopsgroupeu/openprime-keycloak/issues/13)) ([bbf585c](https://github.com/devopsgroupeu/openprime-keycloak/commit/bbf585cbdee3c902df452fb51be207e08b245d4c))

## [0.9.1](https://github.com/devopsgroupeu/openprime-keycloak/compare/v0.9.0...v0.9.1) (2026-08-13)

### 🐛 Bug Fixes

* **chart:** make cluster discovery actually work behind the headless service and network policy ([#12](https://github.com/devopsgroupeu/openprime-keycloak/issues/12)) ([be6ef4e](https://github.com/devopsgroupeu/openprime-keycloak/commit/be6ef4ec347a9f193448858e33247be851b18692))

## [0.9.0](https://github.com/devopsgroupeu/openprime-keycloak/compare/v0.8.0...v0.9.0) (2026-08-13)

### 🚀 Features

* **chart:** add clustering and make dev mode an explicit flag ([#11](https://github.com/devopsgroupeu/openprime-keycloak/issues/11)) ([8c59238](https://github.com/devopsgroupeu/openprime-keycloak/commit/8c592386e6779eeba2911d31b4599db73c252442))

## [0.8.0](https://github.com/devopsgroupeu/openprime-keycloak/compare/v0.7.1...v0.8.0) (2026-08-12)

### 🚀 Features

* **realm:** add SMTP support and derive password reset from it ([#10](https://github.com/devopsgroupeu/openprime-keycloak/issues/10)) ([a7f9c18](https://github.com/devopsgroupeu/openprime-keycloak/commit/a7f9c189befb7e9affc20a128c495fe2caffea95))

## [0.7.1](https://github.com/devopsgroupeu/openprime-keycloak/compare/v0.7.0...v0.7.1) (2026-08-12)

### 🐛 Bug Fixes

* **realm:** stop forcing a logout at 60 minutes and hide the dead password reset ([#9](https://github.com/devopsgroupeu/openprime-keycloak/issues/9)) ([0bc0ce4](https://github.com/devopsgroupeu/openprime-keycloak/commit/0bc0ce4a2d9bd9def651fe2cb71cf6460e6643ef))

## [0.7.0](https://github.com/devopsgroupeu/openprime-keycloak/compare/v0.6.0...v0.7.0) (2026-07-07)

### 🚀 Features

* **realm:** harden production realm (sslRequired, brute-force, PKCE S256, HTTPS-only redirects) ([#7](https://github.com/devopsgroupeu/openprime-keycloak/issues/7)) ([825309b](https://github.com/devopsgroupeu/openprime-keycloak/commit/825309b9ce84dfa246c0e60c1c2dc4733386793d))

## [0.6.0](https://github.com/devopsgroupeu/openprime-keycloak/compare/v0.5.0...v0.6.0) (2026-07-02)

### 🚀 Features

* **chart:** add PodDisruptionBudget template ([#6](https://github.com/devopsgroupeu/openprime-keycloak/issues/6)) ([ffda2b9](https://github.com/devopsgroupeu/openprime-keycloak/commit/ffda2b9b9975aa25006e8c7e6fb6c98d741960ed))

## [0.5.0](https://github.com/devopsgroupeu/openprime-keycloak/compare/v0.4.9...v0.5.0) (2026-06-23)

### 🚀 Features

* update theme design ([#3](https://github.com/devopsgroupeu/openprime-keycloak/issues/3)) ([eda3ca0](https://github.com/devopsgroupeu/openprime-keycloak/commit/eda3ca05e7a0b093d55d6728b136aa8090fbca95))

### 🐛 Bug Fixes

* **ci:** add conventional-changelog-conventionalcommits for conventionalcommits preset ([#5](https://github.com/devopsgroupeu/openprime-keycloak/issues/5)) ([7fbb345](https://github.com/devopsgroupeu/openprime-keycloak/commit/7fbb3453f390ae4167be31350d1a4e1d2a7ea532))
