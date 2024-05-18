package controllers

import (
	"encoding/json"

	"net/http"

	"github.com/gorilla/mux"

	"app/pkg/models"
	"app/pkg/utils"
)

func (server *Server) CreateOrder(w http.ResponseWriter, r *http.Request) {
	orderModel := models.Order{}
	utils.ParseBody(r, &orderModel)
	orderModel.BeforeCreate(server.DB)

	order, err := orderModel.CreateOrder(server.DB)
	if err != nil {
		res, _ := json.Marshal(&status{Check: "Error"})
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)
		w.Write(res)
		return
	}
	res, _ := json.Marshal(&order)
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(res)
}

func (server *Server) GetOrderByOrderID(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	if vars["id"] == "" {
		return
	}
	orderModel := models.Order{}
	_, err := orderModel.GetByOrderID(server.DB, vars["id"])

	if err != nil {
		res, _ := json.Marshal(&status{Check: "Error"})
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)
		w.Write(res)
		return
	}
	res, _ := json.Marshal(&orderModel)
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(res)
}

func (server *Server) GetOrderByUserID(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	if vars["id"] == "" {
		return
	}
	orderModel := models.Order{}
	order, err := orderModel.FindByUserID(server.DB, vars["id"])

	if err != nil {
		res, _ := json.Marshal(&status{Check: "Error"})
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)
		w.Write(res)
		return
	}
	res, _ := json.Marshal(&order)
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(res)
}

func (server *Server) UpdateOrder(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	if vars["id"] == "" {
		return
	}
	orderModel := &models.Order{}
	utils.ParseBody(r, &orderModel)

	order, err := orderModel.UpdateOrder(server.DB, vars["id"])
	if err != nil {
		res, _ := json.Marshal(&status{Check: "Sorry, Something wrong when update order"})
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)
		w.Write(res)
		return
	}
	res, _ := json.Marshal(&order)
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(res)

}
