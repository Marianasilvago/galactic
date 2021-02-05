package app

import (
	"fmt"
	"time"
	"github.com/jinzhu/gorm"
	"github.com/spf13/viper" // for json marshall/ unmarshall
)

func constructDB() *gorm.DB {
	username := viper.Get("db_user")
	password := viper.Get("db_password")
	database := viper.Get("db_database")
	host := viper.Get("db_host")
	port := viper.Get("db_port")

	db, err := gorm.Open("postgres", fmt.Sprintf("host=%s port=%s user=%s dbname=%s password=%s sslmode=disable", host, port, username, database, password))
	if err != nil {
		panic(err)
	}

	// SetMaxIdleConns sets the maximum number of connections in the idle connection pool.
	db.DB().SetMaxIdleConns(10)

	// SetMaxOpenConns sets the maximum number of open connections to the database.
	db.DB().SetMaxOpenConns(50)

	// SetConnMaxLifetime sets the maximum amount of time a connection may be reused.
	db.DB().SetConnMaxLifetime(time.Hour)

	db.LogMode(viper.GetBool("db_log"))

	return db
}

func GetDBConnectionString() string {
	username := viper.Get("db_user")
	password := viper.Get("db_password")
	database := viper.Get("db_database")
	host := viper.Get("db_host")
	port := viper.Get("db_port")

	return fmt.Sprintf("postgres://%s:%s@%s:%s/%s?sslmode=disable", username, password, host, port, database)
}
