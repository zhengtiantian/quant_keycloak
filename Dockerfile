FROM quay.io/keycloak/keycloak:24.0

# 设置默认管理员
ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin

# 拷贝 realm 配置和导入脚本
COPY quant-realm.json /opt/keycloak/data/import/quant-realm.json
COPY import-realm.sh /opt/keycloak/import-realm.sh

RUN chmod +x /opt/keycloak/import-realm.sh

EXPOSE 8080

ENTRYPOINT ["/opt/keycloak/import-realm.sh"]