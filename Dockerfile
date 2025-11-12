# 基于官方 Keycloak 镜像
FROM quay.io/keycloak/keycloak:25.0.0

# 切换为 root 用户以修改权限
USER root

# 拷贝 Realm 配置、导入脚本和 .env 文件
COPY quant-realm.json /opt/keycloak/data/import/quant-realm.json
COPY import-realm.sh /opt/keycloak/
COPY .env /opt/keycloak/.env

# 修改导入脚本权限
RUN chmod +x /opt/keycloak/import-realm.sh

# 切换回 keycloak 用户
USER keycloak

# 暴露端口
EXPOSE 8080

# 启动时加载 .env 并运行 Keycloak（带 realm 导入）
ENTRYPOINT ["/bin/sh", "-c", "set -a && source /opt/keycloak/.env && /opt/keycloak/import-realm.sh"]