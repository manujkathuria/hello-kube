package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	_ "github.com/go-sql-driver/mysql"
	"github.com/jinzhu/configor"
	"os"
	"os/signal"
	"syscall"
	"time"
)

const CONFIGOR_ENV = "uat"

func main() {
	sigterm := make(chan os.Signal, 1)
	signal.Notify(sigterm, syscall.SIGINT, syscall.SIGTERM)

	KubeLoger("INFO", "Main", "Application level:"+CONFIGOR_ENV)
	MariaPrint()

	<-sigterm
	KubeLoger("INFO", "Main", "Application Shutdown")

}

func KubeLoger(level string, funcName string, msg string) {
	var logger KubeLoggerSchema
	Config := LoadConfig()
	logger.Timestamp = time.Now().String()
	logger.Suffix = Config.Appname
	logger.Level = level
	logger.Msg = msg
	logger.LogID = funcName
	jsonMsg, _ := json.Marshal(logger)
	fmt.Println(string(jsonMsg))
}

type KubeLoggerSchema struct {
	Timestamp     string   `json:"@timestamp"`
	Suffix        string   `json:"@suffix"`
	CorrelationID string   `json:"correlationId"`
	Tags          []string `json:"tags"`
	Level         string   `json:"level"`
	Logger        string   `json:"logger"`
	LogID         string   `json:"logId"`
	Msg           string   `json:"msg"`
}

type ConfigSchema struct {
	Appname string `yaml:"appname"`
	Mariadb struct {
		Host     string `yaml:"host"`
		User     string `yaml:"user"`
		Password string `yaml:"password"`
		Database string `yaml:"database"`
	} `yaml:"mariadb"`
}

func LoadConfig() ConfigSchema {

	var config ConfigSchema

	err := configor.Load(&config, "./configs/config.yml")

	if err != nil {
		fmt.Println("File not found", err)
		os.Exit(-1)
	}

	return config
}

func DBConnect() (db *sql.DB) {
	Config := LoadConfig()
	dbDriver := "mysql"
	dbHost := Config.Mariadb.Host
	dbUser := Config.Mariadb.User
	dbPass := Config.Mariadb.Password
	dbName := Config.Mariadb.Database

	fmt.Println(dbUser, dbPass, dbHost)

	db, err := sql.Open(dbDriver, dbUser+":"+dbPass+"@tcp("+dbHost+")/"+dbName)
	if err != nil {
		panic(err.Error())
	}
	return db
}

func MariaPrint() {

	db := DBConnect()
	defer db.Close()
	results, err := db.Query("select * from campaign_master")

	if err != nil {
		panic(err.Error())
	}

	for results.Next() {
		var campaign_code string
		var campaign_name string
		var desc string
		var start_date sql.NullString
		var end_date sql.NullString

		err = results.Scan(&campaign_code, &campaign_name,
			&desc, &start_date, &end_date)

		if err != nil {
			panic(err.Error())
		}
		fmt.Println(campaign_code, campaign_name)
	}

}
