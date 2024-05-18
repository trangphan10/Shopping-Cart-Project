package controllers

import (
	"encoding/json"
	"fmt"

	"net/http"

	"app/pkg/models"
	"app/pkg/utils"

	"github.com/gorilla/mux"
)

func (server *Server) CreateCategory(w http.ResponseWriter, r *http.Request) {
	catModel := models.Category{}
	utils.ParseBody(r, &catModel)

	err := catModel.CreateCategory(server.DB)
	if err != nil {
		res, _ := json.Marshal(&status{Check: "Sorry, Something wrong when create category"})
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)
		w.Write(res)
		return
	}
	res, _ := json.Marshal(&status{Check: "create category OK"})
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(res)
}

func (server *Server) GetCategoryByID(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	if vars["id"] == "" {
		return
	}

	fmt.Println(vars["id"])

	categoryModel := models.Category{}
	category, err := categoryModel.GetCategoryByID(server.DB, vars["id"])
	if err != nil {
		return
	}

	res, _ := json.Marshal(&category)
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(res)
}

func (server *Server) DeleteCategory(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	if vars["id"] == "" {
		return
	}

	categoryModel := models.Category{}
	category, err := categoryModel.DeleteCategory(server.DB, vars["id"])
	if err != nil {
		return
	}

	res, _ := json.Marshal(&category)
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(res)
}

func (server *Server) GetCategories(w http.ResponseWriter, r *http.Request) {
	categoryModel := models.Category{}
	category, err := categoryModel.GetCategories(server.DB)
	if err != nil {
		res, _ := json.Marshal(&status{Check: "Error"})
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)
		w.Write(res)
		return
	}

	res, _ := json.Marshal(&category)
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(res)
}

func (server *Server) UpdateCategory(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	if vars["id"] == "" {
		return
	}

	categoryModel := models.Category{}
	utils.ParseBody(r, &categoryModel)
	// fmt.Println(categoryModel)
	category, err := categoryModel.UpdateCategory(server.DB, vars["id"])
	if err != nil {
		res, _ := json.Marshal(&status{Check: "Error"})
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)
		w.Write(res)
		return
	}

	res, _ := json.Marshal(&category)
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(res)
}
