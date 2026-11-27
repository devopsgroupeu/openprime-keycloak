# Pinned by digest (H96). Dependabot's docker ecosystem bumps tag and digest
# together. The digest is the multi-arch index, so amd64 and arm64 both resolve.
FROM quay.io/keycloak/keycloak:26.8.2@sha256:7e66a96e4739239070aeaf72e4c5decf0f7f682cfc725b9f7ea2b336eaba38b3

# OpenPrime login theme. Root-owned and read-only for the runtime user, so a
# compromised Keycloak process cannot rewrite the login pages it serves.
COPY --chown=0:0 --chmod=755 theme /opt/keycloak/themes/

# Numeric UID:GID 1000:1000 (H97). The upstream image runs as 1000:0; with no
# runAsGroup in the pod spec Kubernetes would inherit GID 0 from the image.
USER 1000:1000

# Run the augmentation now instead of on every container start. Measured on this
# image: boot to "started" drops from ~30s to ~15s (3 runs each, no overlap).
# That time is on the critical path of every rolling restart and reschedule.
#
# These values are passed to the build only, never left as ENV: an ENV would also
# apply at container start and silently override whatever the chart sets.
#
# Keep in sync with the chart/GitOps values. Keycloak refuses to start when a
# runtime value contradicts a persisted one, naming the option — so a mismatch is
# a crashloop, not a silently wrong server.
#
# cache/cache-stack are deliberately absent: they are RUNTIME options in 26.8
# ("will be ignored during build time"), and the chart sets them only when
# clustering is on. Baking them would force ispn on single-replica installs too.
RUN KC_DB=postgres \
    KC_HEALTH_ENABLED=true \
    KC_HTTP_RELATIVE_PATH=/ \
    /opt/keycloak/bin/kc.sh build
