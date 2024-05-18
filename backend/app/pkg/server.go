package pkg

import (
	"app/pkg/controllers"
	"fmt"
	"os"
	// "encoding/json"
	// "github.com/gorilla/mux"
	// "github.com/gin-gonic/gin"
	// "net/http"
)

func getEnv(key, fallback string) string {
	if value, ok := os.LookupEnv(key); ok {
		return value
	}

	return fallback
}

func Run() {
	var server = controllers.Server{}
	var appConfig = controllers.AppConfig{}
	var dbConfig = controllers.DBConfig{}

	host := getEnv("APP_Host", "127.0.0.1")
	appConfig.AppName = "GoToko"
	appConfig.AppEnv = "development"
	appConfig.AppPort = "9000"
	appConfig.AppURL = "http://" + host + ":9000"

	// dbConfig.DBHost = "database-service"
	dbConfig.DBHost = getEnv("DB_Host", "127.0.0.1")
	dbConfig.DBUser = getEnv("DB_User", "tam")
	dbConfig.DBPassword = getEnv("DB_Password", "1")
	dbConfig.DBName = "ECOMMERCE"
	dbConfig.DBPort = "3306"
	dbConfig.DBDriver = "mysql"

	fmt.Println(dbConfig.DBHost + "=====", dbConfig.DBUser + "====" + dbConfig.DBPassword)

	// arg := flag.Arg(0)

	server.Initialize(appConfig, dbConfig)
	server.Run(host + ":" + appConfig.AppPort)
	// server.Router = mux.NewRouter()
	// router := gin.Default()
	// router.GET("/", func(c *gin.Context) {
	// 	c.IndentedJSON(http.StatusOK, map[string]interface{}{"a":1, "b" : "hello"})
	// })
	// router.Run("0.0.0.0:9000")

}
