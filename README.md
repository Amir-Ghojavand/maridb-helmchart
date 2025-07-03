# MariaDB Operator Helm Chart

## Overview
This Helm chart deploys MariaDB using the MariaDB Operator and its Custom Resources (CRDs). It supports all major MariaDB Operator features, including:
- Standalone, Replication, and Galera cluster modes
- User, Grant, Database, and Connection CRDs
- Backup and Restore (PVC, S3, NFS, scheduled, specific databases, etc.)
- TLS, password plugins, and advanced configuration
- Full parameterization for GitOps and production

## Structure
- `templates/` — All CRDs as Helm templates, one per manifest type
- `values.yaml` — All parameters, with examples and comments
- `README.md` — This documentation

## Usage
### Install
```sh
helm install mariadb ./mariadb -f values.yaml
```

### Upgrade
```sh
helm upgrade mariadb ./mariadb -f values.yaml
```

### Uninstall
```sh
helm uninstall mariadb
```

## Configuration
All MariaDB Operator CRDs are parameterized in `values.yaml`. You can enable/disable and configure each CRD independently. See the file for detailed examples and comments.

### Key Sections in `values.yaml`
- `mariadb*` — Standalone, minimal, full, replication, galera, and production cluster CRDs
- `user*` — User, password hash, password plugin, TLS user CRDs
- `grant` — Grant CRD
- `database` — Database CRD
- `connection*` — Connection, TLS, MaxScale, custom DSN CRDs
- `backup*` — All backup CRDs (PVC, S3, NFS, scheduled, specific databases, retention, etc.)
- `restore*` — All restore CRDs (PVC, S3, staging, specific database, target recovery time, etc.)

### Example: Enable a Galera Cluster
```yaml
mariadbGaleraFull:
  rootPasswordSecretKeyRef:
    name: "mariadb-galera-full"
    key: "root-password"
  storage:
    size: 1Gi
  replicas: 3
  galera:
    enabled: true
  # ...
```

### Example: Enable S3 Backup
```yaml
backup:
  storage:
    s3:
      bucket: backups
      endpoint: minio.minio.svc.cluster.local:9000
      # ...
```

## Best Practices
- Use secrets for all passwords and sensitive data
- Use `values.yaml` for GitOps and reproducibility
- Enable ServiceMonitor for Prometheus integration
- Use PVCs and S3 for production backups
- Review and adjust resource requests/limits for your environment

## References
- [MariaDB Operator Docs](https://mariadb.com/docs/skysql-operator/)
- [Helm Best Practices](https://helm.sh/docs/chart_best_practices/)

## Support
For issues, open a ticket in your repository or contact your SRE/Platform team.