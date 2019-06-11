package main

import (
	"encoding/json"
	"fmt"
	"github.com/jinzhu/configor"
	"os"
	"time"
)

const CONFIGOR_ENV = "production"

func main() {

	KubeLoger("INFO", "Main", "Application level:"+CONFIGOR_ENV)
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
