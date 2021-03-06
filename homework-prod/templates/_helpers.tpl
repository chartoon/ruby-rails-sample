{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "homework-prod.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "homework-prod.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{/*
Create a default fully qualified app name.
We truncate at  63 | trimSuffix "-" chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "postgres.fullname" -}}
{{- printf "%s-%s" .Release.Name "postgres" | trunc  63 | trimSuffix "-" -}}
{{- end -}}
