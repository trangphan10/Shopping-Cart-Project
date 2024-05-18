package controllers

import (
	"encoding/json"

	"net/http"

	"github.com/gorilla/mux"

	"app/pkg/models"
	"app/pkg/utils"
)

func (server *Server) GetCart(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	if vars["id"] == "" {
		return
	}
	cartModel := models.Cart{}
	carts, err := cartModel.GetCart(server.DB, vars["id"])
	if err != nil {
		res, _ := json.Marshal(&status{Check: "Error"})
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)
		w.Write(res)
		return
	}

	res, _ := json.Marshal(&carts)
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(res)
}

func (server *Server) AddItem(w http.ResponseWriter, r *http.Request) {
	cartItemModel := models.CartItem{}
	utils.ParseBody(r, &cartItemModel)
	cartItemModel.BeforeCreate()

	cartModel := models.Cart{}
	item, err := cartModel.AddItem(server.DB, cartItemModel)
	if err != nil {
		return
	}

	res, _ := json.Marshal(&item)
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(res)
}

func (server *Server) DeleteItem(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	if vars["id"] == "" {
		return
	}

	cartModel := models.Cart{}
	item, err := cartModel.RemoveItemByID(server.DB, vars["id"])
	if err != nil {
		return
	}

	res, _ := json.Marshal(&item)
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(res)
}
