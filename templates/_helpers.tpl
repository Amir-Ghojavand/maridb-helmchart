{{/*
Common labels for all resources
*/}}
{{- define "mariadb.labels" -}}
app: {{ .Chart.Name }}
release: {{ .Release.Name }}
{{- end -}}

{{/*
Common annotations for all resources
*/}}
{{- define "mariadb.annotations" -}}
{{- if .Values.annotations }}
{{- toYaml .Values.annotations | nindent 4 }}
{{- end }}
{{- end -}}

{{/*
Generate the full name of the resource
*/}}
{{- define "mariadb.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{/*
Default image for MariaDB
*/}}
{{- define "mariadb.image" -}}
{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Resource requests and limits
*/}}
{{- define "mariadb.resources" -}}
resources:
  requests:
    cpu: {{ .Values.resources.requests.cpu | default "100m" }}
    memory: {{ .Values.resources.requests.memory | default "256Mi" }}
  limits:
    cpu: {{ .Values.resources.limits.cpu | default "500m" }}
    memory: {{ .Values.resources.limits.memory | default "512Mi" }}
{{- end -}}

{{/*
Liveness and readiness probes
*/}}
{{- define "mariadb.probes" -}}
livenessProbe:
  tcpSocket:
    port: {{ .Values.service.port }}
  initialDelaySeconds: {{ .Values.livenessProbe.initialDelaySeconds | default 30 }}
  periodSeconds: {{ .Values.livenessProbe.periodSeconds | default 10 }}
readinessProbe:
  tcpSocket:
    port: {{ .Values.service.port }}
  initialDelaySeconds: {{ .Values.readinessProbe.initialDelaySeconds | default 30 }}
  periodSeconds: {{ .Values.readinessProbe.periodSeconds | default 10 }}
{{- end -}}

{{/*
Get the storage class for PVC
*/}}
{{- define "mariadb.pvc.storageClass" -}}
{{ .Values.persistence.storageClass | default "standard" }}
{{- end -}}