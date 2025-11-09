# 基于官方 Keycloak 镜像
FROM quay.io/keycloak/keycloak:25.0.0

# 切换为 root 用户以修改权限
USER root

# 拷贝 Realm 配置和导入脚本
COPY quant-realm.json /opt/keycloak/data/import/quant-realm.json
COPY import-realm.sh /opt/keycloak/

# 给导入脚本加执行权限
RUN chmod +x /opt/keycloak/import-realm.sh

# 切换回 keycloak 用户，避免权限问题
USER keycloak

# 环境变量配置
ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin
ENV KC_DB=dev-mem
ENV KC_HTTP_PORT=8080

# 暴露端口
EXPOSE 8080

# 启动时执行导入脚本
ENTRYPOINT ["/opt/keycloak/import-realm.sh"]