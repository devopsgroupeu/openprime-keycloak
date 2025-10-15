FROM quay.io/keycloak/keycloak:26.2.0

# Copy OpenPrime custom theme
COPY theme /opt/keycloak/themes/

# Set proper ownership and permissions
USER root
RUN chown -R keycloak:keycloak /opt/keycloak/themes/openprime && \
    chmod -R 755 /opt/keycloak/themes/openprime

USER 1000
