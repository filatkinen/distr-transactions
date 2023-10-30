package service

import (
	"encoding/json"
	"github.com/filatkinen/distr-transactions/internal/httpcommon"
	"github.com/gorilla/mux"
	"net/http"
)

func (s *Service) getroute() http.Handler {
	r := mux.NewRouter()
	r.HandleFunc("/", s.GetRoot).Methods("GET")
	r.HandleFunc("", s.GetRoot).Methods("GET")
	r.HandleFunc("/set", s.Set).Methods("POST")
	return r
}

func (s *Service) GetRoot(w http.ResponseWriter, _ *http.Request) {
	w.Write([]byte("OrderPayment service Ok\n"))
}

func (s *Service) Set(w http.ResponseWriter, r *http.Request) {
	var set SetService
	dec := json.NewDecoder(r.Body)
	err := dec.Decode(&set)
	if err != nil {
		httpcommon.ClientError(w, http.StatusBadRequest, err.Error())
		return
	}
	s.lock.Lock()
	s.Mistakes = set.Mistakes
	s.lock.Unlock()

	httpcommon.WriteHTTPTextOK(w, "OK")
}
