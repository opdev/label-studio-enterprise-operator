{{/*
Expand the name
*/}}
{{- define "lse-app.name" -}}
{{- default "lse-app" .Values.app.NameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- define "lse-rqworker.name" -}}
{{- default "lse-rqworker" .Values.rqworker.NameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- define "lse-rqworker-high.name" -}}
{{- default "lse-rqworker-high" .Values.rqworker.NameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- define "lse-pvc.name" -}}
{{- "lse-pvc" | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- define "lse-secrets.name" -}}
{{- "lse-secrets" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Return the PVC name (only in standalone mode)
*/}}
{{- define "lse-pvc.claimName" -}}
{{- if and .Values.global.persistence.config.volume.existingClaim }}
    {{- printf "%s" (tpl .Values.global.persistence.config.volume.existingClaim $) -}}
{{- else -}}
    {{- printf "%s" (include "lse-pvc.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "lse-app.fullname" -}}
{{- if .Values.app.FullnameOverride }}
{{- .Values.app.FullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default "lse-app" .Values.app.FullnameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "lse-rqworker.fullname" -}}
{{- if .Values.rqworker.FullnameOverride }}
{{- .Values.rqworker.FullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default "lse-rqworker" .Values.rqworker.FullnameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "lse-rqworker-high.fullname" -}}
{{- if .Values.rqworker.queues.high.FullnameOverride }}
{{- .Values.rqworker.queues.high.FullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default "lse-rqworker-high" .Values.rqworker.queues.high.FullnameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "lse-pvc.fullname" -}}
{{- $name := "lse-pvc" }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{- define "lse-secrets.fullname" -}}
{{- $name := "lse-secrets" }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "lse.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels for lse-app
*/}}
{{- define "lse-app.labels" -}}
helm.sh/chart: {{ include "lse.chart" . }}
{{ include "lse-app.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels for lse-app
*/}}
{{- define "lse-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "lse-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common labels for lse-pvc
*/}}
{{- define "lse-pvc.labels" -}}
helm.sh/chart: {{ include "lse.chart" . }}
{{ include "lse-pvc.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels for lse-pvc
*/}}
{{- define "lse-pvc.selectorLabels" -}}
app.kubernetes.io/name: {{ include "lse-pvc.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common labels for lse-pvc
*/}}
{{- define "lse-secrets.labels" -}}
helm.sh/chart: {{ include "lse.chart" . }}
{{ include "lse-secrets.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels for lse-pvc
*/}}
{{- define "lse-secrets.selectorLabels" -}}
app.kubernetes.io/name: {{ include "lse-secrets.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common labels for lse-rqworker
*/}}
{{- define "lse-rqworker.labels" -}}
helm.sh/chart: {{ include "lse.chart" . }}
{{ include "lse-rqworker.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels for lse-rqworker
*/}}
{{- define "lse-rqworker.selectorLabels" -}}
app.kubernetes.io/part-of: label-studio-enterprise
app.kubernetes.io/name: {{ include "lse-rqworker.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common labels for lse-rqworker-high
*/}}
{{- define "lse-rqworker-high.labels" -}}
helm.sh/chart: {{ include "lse.chart" . }}
{{ include "lse-rqworker-high.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels for lse-rqworker-high
*/}}
{{- define "lse-rqworker-high.selectorLabels" -}}
app.kubernetes.io/part-of: label-studio-enterprise
app.kubernetes.io/name: {{ include "lse-rqworker-high.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the app service account to use
*/}}
{{- define "lse-app.serviceAccountName" -}}
{{- if .Values.app.serviceAccount.create }}
{{- default (include "lse-app.fullname" .) .Values.app.serviceAccount.name }}
{{- else }}
{{- default "lse" .Values.app.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the rqworker service account to use
*/}}
{{- define "lse-rqworker.serviceAccountName" -}}
{{- if .Values.rqworker.serviceAccount.create }}
{{- default (include "lse-rqworker.fullname" .) .Values.rqworker.serviceAccount.name }}
{{- else }}
{{- default "rqworker" .Values.rqworker.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "tplvalues.render" -}}
{{- if typeIs "string" .value }}
    {{- tpl .value .context }}
{{- else }}
    {{- tpl (.value | toYaml) .context }}
{{- end }}
{{- end -}}

{{/*{{- define "lse-app.endpoint" -}}*/}}
{{/*{{- if .Values.app.ingress.enabled }}http{{ if $.Values.app.ingress.tls }}s{{ end }}://{{ .Values.app.ingress.host }}*/}}
{{/*{{- else }}*/}}
{{/*{{- include "lse-app.fullname" . }}:{{ .Values.app.service.port }}*/}}
{{/*{{- end }}*/}}
{{/*{{- end}}*/}}

{{/*
Set's common environment variables
*/}}
{{- define "lse.common.envs" -}}
          {{- if (and .Values.global.enterpriseLicense.secretName .Values.global.enterpriseLicense.secretKey) }}
            - name: LICENSE
              valueFrom:
                secretKeyRef:
                  name: {{ .Values.global.enterpriseLicense.secretName }}
                  key: {{ .Values.global.enterpriseLicense.secretKey }}
          {{- end }}
            - name: SKIP_DB_MIGRATIONS
              value: "{{ .Values.global.skipDbMigrations | default "true" }}"
            - name: DJANGO_DB
              value: {{ .Values.global.djangoConfig.db }}
            - name: DJANGO_SETTINGS_MODULE
              value: {{ .Values.global.djangoConfig.settings_module }}
            {{- if (and .Values.postgresql.enabled .Values.postgresql.auth.database ) }}
            - name: POSTGRE_NAME
              value: {{ .Values.postgresql.auth.database }}
            {{- else }}
            {{- if .Values.global.pgConfig.dbName }}
            - name: POSTGRE_NAME
              value: {{ .Values.global.pgConfig.dbName }}
            {{- end }}
            {{- end }}
            {{- if .Values.global.pgConfig.host }}
            - name: POSTGRE_HOST
              value: {{ .Values.global.pgConfig.host }}
            {{- else }}
            {{- if .Values.postgresql.enabled }}
            - name: POSTGRE_HOST
              value: {{ .Release.Name }}-postgresql-hl
            {{- end }}
            {{- end }}
            {{- if (and .Values.postgresql.enabled .Values.postgresql.servicePort) }}
            - name: POSTGRE_PORT
              value: {{ .Values.postgresql.servicePort | quote }}
            {{- else }}
            {{- if .Values.global.pgConfig.port }}
            - name: POSTGRE_PORT
              value: {{ .Values.global.pgConfig.port | quote }}
            {{- end }}
            {{- end }}
            {{- if (and .Values.postgresql.enabled .Values.postgresql.auth.username) }}
            - name: POSTGRE_USER
              value: {{ .Values.postgresql.auth.username}}
            {{- else }}
            {{- if .Values.global.pgConfig.userName }}
            - name: POSTGRE_USER
              value: {{ .Values.global.pgConfig.userName }}
            {{- end }}
            {{- end }}
            {{- if (and .Values.postgresql.enabled .Values.postgresql.auth.password) }}
            - name: POSTGRE_PASSWORD
              value: {{ .Values.postgresql.auth.password }}
            {{- else }}
            {{- if (and .Values.global.pgConfig.password.secretName .Values.global.pgConfig.password.secretKey) }}
            - name: POSTGRE_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: {{ .Values.global.pgConfig.password.secretName }}
                  key: {{ .Values.global.pgConfig.password.secretKey }}
            {{- end }}
            {{- end }}
            {{- if .Values.global.redisConfig.host }}
            - name: REDIS_LOCATION
              value: {{ .Values.global.redisConfig.host }}
            {{- else }}
            {{- if .Values.redis.enabled }}
            - name: REDIS_LOCATION
              value: redis{{ if .Values.redis.tls.enabled }}s{{ end }}://{{ .Release.Name }}-redis-headless:6379/1
            {{- end }}
            {{- end }}
            {{- if not .Values.global.extraEnvironmentVars.LABEL_STUDIO_HOST }}
            {{- if .Values.app.ingress.enabled }}
            - name: LABEL_STUDIO_HOST
              value: http{{ if .Values.app.ingress.tls }}s{{ end }}://{{ .Values.app.ingress.host }}{{ default "" .Values.global.contextPath }}
            {{- end }}
            {{- end }}
            {{- if (and .Values.global.redisConfig.password.secretName .Values.global.redisConfig.password.secretKey) }}
            - name: REDIS_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: {{ .Values.global.redisConfig.password.secretName }}
                  key: {{ .Values.global.redisConfig.password.secretKey }}
            {{- end }}
            - name: PYTHONUNBUFFERED
              value: "1"
            {{- if .Values.global.extraEnvironmentVars -}}
            {{- range $key, $value := .Values.global.extraEnvironmentVars }}
            - name: {{ printf "%s" $key | replace "." "_" | upper | quote }}
              value: {{ $value | quote }}
            {{- end }}
            {{- end }}
            {{- if .Values.global.extraEnvironmentSecrets -}}
            {{- range $key, $value := .Values.global.extraEnvironmentSecrets }}
            - name: {{ printf "%s" $key | replace "." "_" | upper | quote }}
              valueFrom:
                secretKeyRef:
                  name: {{ $value.secretName }}
                  key: {{ $value.secretKey }}
            {{- end }}
            {{- end }}
            {{- if .Values.minio.enabled }}
            - name: MINIO_STORAGE_MEDIA_USE_PRESIGNED
              value: "false"
            - name: MINIO_STORAGE_BUCKET_NAME
              value: "media"
            - name: MINIO_STORAGE_ENDPOINT
              value: http://{{ .Release.Name }}-minio:9000
            {{- if .Values.minio.accessKey.password }}
            - name: MINIO_STORAGE_ACCESS_KEY
              value: {{ .Values.minio.accessKey.password | quote }}
            {{- else }}
            - name: MINIO_STORAGE_ACCESS_KEY
              valueFrom:
                secretKeyRef:
                  name: {{ .Release.Name }}-minio
                  key: access-key
            {{- end }}
            {{- if .Values.minio.secretKey.password }}
            - name: MINIO_STORAGE_SECRET_KEY
              value: {{ .Values.minio.secretKey.password | quote }}
            {{- else }}
            - name: MINIO_STORAGE_SECRET_KEY
              valueFrom:
                secretKeyRef:
                  name: {{ .Release.Name }}-minio
                  key: secret-key
            {{- end }}
            {{- end }}
            - name: STORAGE_PERSISTENCE
              value: "{{ .Values.global.persistence.enabled | default "false" }}"
            {{- if .Values.global.persistence.enabled }}
            {{- if .Values.minio.enabled }}
            - name: MINIO_SKIP
              value: "1"
            {{- end }}
            - name: STORAGE_TYPE
              value: {{ .Values.global.persistence.type }}
            {{- if eq .Values.global.persistence.type "s3" }}
            {{- if or .Values.global.persistence.config.s3.accessKey .Values.global.persistence.config.s3.accessKeyExistingSecret }}
            - name: STORAGE_AWS_ACCESS_KEY_ID
              valueFrom:
                secretKeyRef:
                  {{- if and .Values.global.persistence.config.s3.accessKeyExistingSecret .Values.global.persistence.config.s3.accessKeyExistingSecretKey }}
                  name: {{ .Values.global.persistence.config.s3.accessKeyExistingSecret }}
                  key: {{ .Values.global.persistence.config.s3.accessKeyExistingSecretKey }}
                  {{- else }}
                  name: {{ include "lse-secrets.fullname" . }}
                  key: storage-aws-access-key-id
                  {{- end }}
            {{- end }}
            {{- if or .Values.global.persistence.config.s3.secretKey .Values.global.persistence.config.s3.secretKeyExistingSecret }}
            - name: STORAGE_AWS_SECRET_ACCESS_KEY
              valueFrom:
                secretKeyRef:
                  {{- if and .Values.global.persistence.config.s3.secretKeyExistingSecret .Values.global.persistence.config.s3.secretKeyExistingSecretKey }}
                  name: {{ .Values.global.persistence.config.s3.secretKeyExistingSecret }}
                  key: {{ .Values.global.persistence.config.s3.secretKeyExistingSecretKey }}
                  {{- else }}
                  name: {{ include "lse-secrets.fullname" . }}
                  key: storage-aws-secret-access-key
                  {{- end }}
            {{- end }}
            - name: STORAGE_AWS_REGION_NAME
              value: {{ .Values.global.persistence.config.s3.region }}
            - name: STORAGE_AWS_BUCKET_NAME
              value: {{ .Values.global.persistence.config.s3.bucket }}
            - name: STORAGE_AWS_FOLDER
              value: {{ .Values.global.persistence.config.s3.folder | quote }}
            - name: STORAGE_AWS_X_AMZ_EXPIRES
              value: {{ .Values.global.persistence.config.s3.urlExpirationSecs | quote }}
            {{- end }}
            {{- if eq .Values.global.persistence.type "azure" }}
            - name: STORAGE_AZURE_CONTAINER_NAME
              value: {{ .Values.global.persistence.config.azure.containerName }}
            - name: STORAGE_AZURE_FOLDER
              value: {{ .Values.global.persistence.config.azure.folder | quote }}
            - name: STORAGE_AZURE_URL_EXPIRATION_SECS
              value: {{ .Values.global.persistence.config.azure.urlExpirationSecs | quote }}
            - name: STORAGE_AZURE_ACCOUNT_NAME
              valueFrom:
                secretKeyRef:
                  {{- if and .Values.global.persistence.config.azure.storageAccountNameExistingSecret .Values.global.persistence.config.azure.storageAccountNameExistingSecretKey }}
                  name: {{ .Values.global.persistence.config.azure.storageAccountNameExistingSecret }}
                  key: {{ .Values.global.persistence.config.azure.storageAccountNameExistingSecretKey }}
                  {{- else }}
                  name: {{ include "lse-secrets.fullname" . }}
                  key: storage-azure-account-name
                  {{- end }}
            - name: STORAGE_AZURE_ACCOUNT_KEY
              valueFrom:
                secretKeyRef:
                  {{- if and .Values.global.persistence.config.azure.storageAccountKeyExistingSecret .Values.global.persistence.config.azure.storageAccountKeyExistingSecretKey }}
                  name: {{ .Values.global.persistence.config.azure.storageAccountKeyExistingSecret }}
                  key: {{ .Values.global.persistence.config.azure.storageAccountKeyExistingSecretKey }}
                  {{- else }}
                  name: {{ include "lse-secrets.fullname" . }}
                  key: storage-azure-account-key
                  {{- end }}
            {{- end }}
            {{- if eq .Values.global.persistence.type "gcs" }}
            - name: STORAGE_GCS_BUCKET_NAME
              value: {{ .Values.global.persistence.config.gcs.bucket }}
            - name: STORAGE_GCS_PROJECT_ID
              value: {{ .Values.global.persistence.config.gcs.projectID }}
            - name: STORAGE_GCS_FOLDER
              value: {{ .Values.global.persistence.config.gcs.folder | quote }}
            - name: STORAGE_GCS_EXPIRATION_SECS
              value: {{ .Values.global.persistence.config.gcs.urlExpirationSecs | quote }}
            {{- if .Values.global.persistence.config.gcs.applicationCredentialsJSON }}
            - name: GOOGLE_APPLICATION_CREDENTIALS
              value: "/opt/heartex/secrets/gcs/key.json"
            {{- else if .Values.global.persistence.config.gcs.applicationCredentialsJSONExistingSecretKey }}
            - name: GOOGLE_APPLICATION_CREDENTIALS
              value: "/opt/heartex/secrets/gcs/{{ .Values.global.persistence.config.gcs.applicationCredentialsJSONExistingSecretKey }}"
            {{- end }}
            {{- end }}
            {{- end }}
            {{- if .Values.global.featureFlags -}}
            {{- range $key, $value := .Values.global.featureFlags }}
            - name: {{ printf "%s" $key | quote }}
              value: {{ $value | quote }}
            {{- end }}
            {{- end }}
            {{- if .Values.global.pgConfig.ssl.pgSslMode }}
            - name: POSTGRE_SSL_MODE
              value: {{ .Values.global.pgConfig.ssl.pgSslMode | quote }}
            {{- end }}
            {{- if .Values.global.pgConfig.ssl.pgSslRootCertSecretKey }}
            - name: POSTGRE_SSLROOTCERT
              value: "/opt/heartex/secrets/pg_certs/{{ .Values.global.pgConfig.ssl.pgSslRootCertSecretKey }}"
            {{- end }}
            {{- if .Values.global.pgConfig.ssl.pgSslCertSecretKey }}
            - name: POSTGRE_SSLCERT
              value: "/opt/heartex/secrets/pg_certs/{{ .Values.global.pgConfig.ssl.pgSslCertSecretKey }}"
            {{- end }}
            {{- if .Values.global.pgConfig.ssl.pgSslKeySecretKey }}
            - name: POSTGRE_SSLKEY
              value: "/opt/heartex/secrets/pg_certs/{{ .Values.global.pgConfig.ssl.pgSslKeySecretKey }}"
            {{- end }}
            {{- if .Values.global.redisConfig.ssl.redisSslCertReqs }}
            - name: REDIS_SSL_CERTS_REQS
              value: {{ .Values.global.redisConfig.ssl.redisSslCertReqs | quote }}
            - name: REDIS_SSL
              value: "1"
            {{- end }}
            {{- if .Values.global.redisConfig.ssl.redisSslCaCertsSecretKey }}
            - name: REDIS_SSL_CA_CERTS
              value: "/opt/heartex/secrets/redis_certs/{{ .Values.global.redisConfig.ssl.redisSslCaCertsSecretKey }}"
            {{- end }}
            {{- if .Values.global.redisConfig.ssl.redisSslCertFileSecretKey }}
            - name: REDIS_SSL_CERTFILE
              value: "/opt/heartex/secrets/redis_certs/{{ .Values.global.redisConfig.ssl.redisSslCertFileSecretKey }}"
            {{- end }}
            {{- if .Values.global.redisConfig.ssl.redisSslKeyFileSecretKey }}
            - name: REDIS_SSL_KEYFILE
              value: "/opt/heartex/secrets/redis_certs/{{ .Values.global.redisConfig.ssl.redisSslKeyFileSecretKey }}"
            {{- end }}
{{- end -}}
