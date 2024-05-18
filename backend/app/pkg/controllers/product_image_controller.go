package controllers

import (
	"encoding/json"

	"net/http"

	"github.com/google/uuid"
	"github.com/gorilla/mux"

	"app/pkg/models"
	"app/pkg/utils"
)

func (server *Server) CreateImageByProductID(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	if vars["id"] == "" {
		return
	}

	p_imgModel := models.ProductImage{}
	utils.ParseBody(r, &p_imgModel)
	p_imgModel.ProductID = vars["id"]
	p_imgModel.ID = uuid.New().String()

	p_img, err := p_imgModel.CreateProductImg(server.DB)
	if err != nil {
		return
	}

	res, _ := json.Marshal(&p_img)
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(res)
}

func (server *Server) DeleteImageByProductID(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	if vars["id"] == "" {
		return
	}

	p_imgModel := &models.ProductImage{}
	p_img, err := p_imgModel.DeleteProductImage(server.DB, vars["id"])
	if err != nil {
		return
	}

	res, _ := json.Marshal(&p_img)
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(res)
}

