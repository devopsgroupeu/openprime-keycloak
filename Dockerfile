FROM quay.io/keycloak/keycloak:26.2.0

# Copy OpenPrime custom theme
COPY theme /opt/keycloak/themes/

# Set proper ownership and permissions
USER root
RUN chown -R keycloak:keycloak /opt/keycloak/themes/openprime && \
    chmod -R 755 /opt/keycloak/themes/openprime

USER 1000

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
# cache/cache-stack are deliberately absent: they are RUNTIME options in 26.2
# ("will be ignored during build time"), and the chart sets them only when
# clustering is on. Baking them would force ispn on single-replica installs too.
RUN KC_DB=postgres \
    KC_HEALTH_ENABLED=true \
    KC_HTTP_RELATIVE_PATH=/ \
    /opt/keycloak/bin/kc.sh build
