package app

import (
	"github.com/RichardKnop/machinery/v1"
	// "github.com/aws/aws-sdk-go/aws/session"
	// "github.com/casbin/casbin/v2"
	gormadapter "github.com/casbin/gorm-adapter/v2"
	"github.com/jinzhu/gorm"
	"github.com/qor/media"
	"github.com/qor/oss"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/viper" // json unmarshall primarily
	"gitlab.com/reenue/graphql-server/jobs"
)

type App struct {
	AWS         *session.Session
	DB          *gorm.DB         // DB Connection
	E           *casbin.Enforcer // Enforcer
	Key         string           // App Key
	Mailservice string
	Queue       *machinery.Server
	Storage     oss.StorageInterface
	Services    *Services
}

func New() *App {
	db := constructDB()
	aws := NewAWS()

	a, err := gormadapter.NewAdapterByDB(db)
	if err != nil {
		log.Error(err)
	}

	e, err := casbin.NewEnforcer("config/enforcer.conf", a)
	if err != nil {
		log.Error(err)
	}

	media.RegisterCallbacks(db)

	logger()

	services := getServices(db, e)

	app := &App{
		AWS:         aws,
		DB:          db,
		Key:         viper.GetString("app_key"),
		E:           e,
		Mailservice: viper.GetString("mail_service"),
		Queue:       jobs.NewQueue(db, services.Forecast),
		Storage:     NewStorage(aws),
		Services:    services,
	}

	return app
}
