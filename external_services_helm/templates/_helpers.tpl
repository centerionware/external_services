{{/* helpers for names */}}
{{- define "fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 -}}
{{- end -}}

{{- define "svcName" -}}
{{- printf "%s-%s" $.Release.Name . | trunc 63 -}}
{{- end -}}

{{- define "mwName" -}}
{{- printf "%s-%s" $.Release.Name . | trunc 63 -}}
{{- end -}}