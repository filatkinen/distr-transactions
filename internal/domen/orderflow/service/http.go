package service

import (
	"github.com/gorilla/mux"
	"net/http"
)

func (s *Service) getroute() http.Handler {
	r := mux.NewRouter()
	r.HandleFunc("/", s.GetRoot).Methods("GET")
	r.HandleFunc("", s.GetRoot).Methods("GET")
	//r.HandleFunc("/neworder", s.NewOrderHandler).Methods("POST")
	return r
}

func (s *Service) GetRoot(w http.ResponseWriter, _ *http.Request) {
	w.Write([]byte("OrderFlow service Ok\n"))
}

//func (s *Service) NewOrderHandler(w http.ResponseWriter, r *http.Request) {
//
//	var order model.Order
//	dec := json.NewDecoder(r.Body)
//	err := dec.Decode(&order)
//	if err != nil {
//		httpcommon.ClientError(w, http.StatusBadRequest, err.Error())
//		return
//	}
//
//	orderInfo, err := s.NewOrder(r.Context(), order)
//	if err != nil {
//		httpcommon.ServerError(w, http.StatusInternalServerError, err.Error())
//		return
//	}
//
//	httpcommon.WriteHTTPJsonOKIdent(w, orderInfo)
//}
