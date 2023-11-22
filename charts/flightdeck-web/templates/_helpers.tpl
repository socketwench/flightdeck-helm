{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "flightdeck-web.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "flightdeck-web.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "flightdeck-web.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "flightdeck-web.labels" -}}
helm.sh/chart: {{ include "flightdeck-web.chart" . }}
{{ include "flightdeck-web.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "flightdeck-web.selectorLabels" -}}
app.kubernetes.io/name: {{ include "flightdeck-web.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "flightdeck-web.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "flightdeck-web.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create image name and tag used by the deployment.
*/}}
{{- define "flightdeck-web.image" -}}
{{- $name := .Values.image.repository -}}
{{- $tag := .Values.image.tag | default .Chart.AppVersion -}}
{{- printf "%s:%s" $name $tag -}}
{{- end -}}

{{/*
Create image name and tag used by the deployment.
*/}}
{{- define "flightdeck-web.varnishImage" -}}
{{- $name := .Values.varnish.image.repository -}}
{{- $tag := .Values.varnish.image.tag | default .Chart.AppVersion -}}
{{- printf "%s:%s" $name $tag -}}
{{- end -}}

{{/*
Create image name and tag used by the deployment.
*/}}
{{- define "flightdeck-web.memcacheImage" -}}
{{- $name := .Values.memcache.image.repository -}}
{{- $tag := .Values.memcache.image.tag | default .Chart.AppVersion -}}
{{- printf "%s:%s" $name $tag -}}
{{- end -}}
