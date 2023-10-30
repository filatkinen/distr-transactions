package httpcommon

import (
	"encoding/json"
	"fmt"
	"net/http"
)

func ClientError(w http.ResponseWriter, status int, message string) {
	w.Header().Set("Content-Type", "text/plain; charset=utf-8")
	w.Header().Set("X-Content-Type-Options", "nosniff")
	w.WriteHeader(status)
	if message == "" {
		fmt.Fprintln(w, http.StatusText(status))
		return
	}
	fmt.Fprintf(w, "%s: %s\n", http.StatusText(status), message)
}

func ServerError(w http.ResponseWriter, status int, message string) {
	w.Header().Set("Content-Type", "text/plain; charset=utf-8")
	w.Header().Set("X-Content-Type-Options", "nosniff")
	w.Header().Set("Retry-After", "10")
	w.WriteHeader(status)
	if message == "" {
		fmt.Fprintln(w, http.StatusText(status))
		return
	}
	fmt.Fprintf(w, "%s: %s\n", http.StatusText(status), message)
}

func ToJSON(value any) (string, error) {
	data, err := json.Marshal(value)
	if err != nil {
		return "", err
	}
	return string(data), nil
}

func ToJSONIdent(value any) (string, error) {
	data, err := json.MarshalIndent(value, "", " ")
	if err != nil {
		return "", err
	}
	return string(data), nil
}

func WriteHTTPJsonOK(w http.ResponseWriter, value any) {
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	w.WriteHeader(http.StatusOK)
	data, err := ToJSON(value)
	if err != nil {
		fmt.Fprintln(w, "request OK")
		fmt.Fprintln(w, "error marshaling response with details of request")
		return
	}
	fmt.Fprintln(w, data)
}

func WriteHTTPJsonOKIdent(w http.ResponseWriter, value any) {
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	w.WriteHeader(http.StatusOK)
	data, err := ToJSONIdent(value)
	if err != nil {
		fmt.Fprintln(w, "request OK")
		fmt.Fprintln(w, "error marshaling response with details of request")
		return
	}
	fmt.Fprintln(w, data)
}

func WriteHTTPTextOK(w http.ResponseWriter, value string) {
	w.Header().Set("Content-Type", "text/plain; charset=UTF-8")
	w.WriteHeader(http.StatusOK)
	fmt.Fprintln(w, value)
}
