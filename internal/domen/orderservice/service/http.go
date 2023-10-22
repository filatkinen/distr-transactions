package service

import (
	"github.com/gorilla/mux"
	"net/http"
)

func (s *Service) getroute() http.Handler {
	r := mux.NewRouter()
	r.HandleFunc("/", s.GetRoot).Methods("GET")
	r.HandleFunc("", s.GetRoot).Methods("GET")
	return r
}

func (s *Service) GetRoot(w http.ResponseWriter, _ *http.Request) {
	w.Write([]byte("Ok\n"))
}
