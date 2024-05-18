package controllers

import (
	"encoding/json"

	// "fmt"
	"app/pkg/models"
	"app/pkg/utils"
	"net/http"

	"github.com/google/uuid"
	"github.com/gorilla/mux"
)

// store variable in base_controller file

type user_login struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

type status struct {
	Check string
}

func (server *Server) DoLogin(w http.ResponseWriter, r *http.Request) {
	user_temp := &models.User{}
	utils.ParseBody(r, &user_temp)

	userModel := models.User{}
	user, err := userModel.FindByEmail(server.DB, user_temp.Email)
	if err != nil {
		// SetFlash(w, r, "error", "email or password invalid")

		res, _ := json.Marshal(&status{Check: "Error"})
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)
		w.Write(res)
		return
	}

	if !ComparePassword(user_temp.Password, user.Password) {
		// SetFlash(w, r, "error", "email or password invalid")
		res, _ := json.Marshal(&status{Check: "Error"})
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)
		w.Write(res)
		return
	}

	session, _ := store.Get(r, sessionUser)
	session.Values["id"] = user.ID
	session.Save(r, w)
	// fmt.Println(session.Values["id"])
	user_temp.ID = user.ID
	user_temp.FirstName = user.FirstName
	user_temp.LastName = user.LastName
	user_temp.Address = user.Address
	res, _ := json.Marshal(&user_temp)
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(res)
	// http.Redirect(w, r, "/", http.StatusSeeOther)
}

// display register interface

func (server *Server) DoRegister(w http.ResponseWriter, r *http.Request) {

	// w.Header().Set("Access-Control-Allow-Origin", "*")
	// w.Header().Set("Access-Control-Allow-Methods", "POST, GET, OPTIONS, PUT, DELETE")

	userModel := &models.User{}
	utils.ParseBody(r, userModel)
	userModel.ID = uuid.New().String()

	existUser, _ := userModel.FindByEmail(server.DB, userModel.Email)
	if existUser != nil {
		// SetFlash(w, r, "error", "Sorry, email already registered")
		res, _ := json.Marshal(&status{Check: "Sorry, email already registered"})
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)
		w.Write(res)
		return
	}

	hashedPassword, _ := MakePassword(userModel.Password)
	userModel.Password = hashedPassword

	user, err := userModel.CreateUser(server.DB)
	if err != nil {
		// SetFlash(w, r, "error", "Sorry, registration failed")
		res, _ := json.Marshal(&status{Check: "Sorry, registration failed"})
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)
		w.Write(res)
		return
	}

	session, _ := store.Get(r, sessionUser)
	session.Values["id"] = user.ID
	session.Save(r, w)

	res, _ := json.Marshal(&status{Check: "ok"})
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(res)
	// http.Redirect(w, r, "/", http.StatusSeeOther)
}

func (server *Server) Logout(w http.ResponseWriter, r *http.Request) {
	session, _ := store.Get(r, sessionUser)

	session.Values["id"] = nil
	session.Save(r, w)

	res, _ := json.Marshal(&status{Check: "ok"})
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(res)

	// http.Redirect(w, r, "/", http.StatusSeeOther)
}

func (server *Server) DeleteUser(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	if vars["id"] == "" {
		return
	}
	userModel := models.User{}
	_, err := userModel.RemoveUser(server.DB, vars["id"])
	if err != nil {
		res, _ := json.Marshal(&status{Check: "Error"})
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)
		w.Write(res)
		return
	}
	session, _ := store.Get(r, sessionUser)

	session.Values["id"] = nil
	session.Save(r, w)

	res, _ := json.Marshal(&status{Check: "ok"})
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(res)
}

func (server *Server) UpdateUser(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	if vars["id"] == "" {
		return
	}

	userModel := models.User{}
	utils.ParseBody(r, &userModel)
	// fmt.Println(userModel)
	if userModel.Password != "" {
		userModel.Password, _ = MakePassword(userModel.Password)
	}
	user, err := userModel.UpdateUser(server.DB, vars["id"])
	if err != nil {
		res, _ := json.Marshal(&status{Check: "Error"})
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)
		w.Write(res)
		return
	}

	res, _ := json.Marshal(&user)
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(res)
}

func (server *Server) GetUser(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	if vars["id"] == "" {
		return
	}

	userModel := models.User{}
	// fmt.Println(userModel)
	user, err := userModel.FindByID(server.DB, vars["id"])
	if err != nil {
		res, _ := json.Marshal(&status{Check: "Error"})
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)
		w.Write(res)
		return
	}

	res, _ := json.Marshal(&user)
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(res)
}
