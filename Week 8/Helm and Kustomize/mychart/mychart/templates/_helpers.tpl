{{- define "mychart.fullname" -}}
{{ printf "%s-%s" .Release.Name .Chart.Name }}
{{- end }}
