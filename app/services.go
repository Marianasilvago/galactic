package app

import (
	"github.com/casbin/casbin/v2"
	"github.com/jinzhu/gorm"
	"gitlab.com/reenue/graphql-server/services/auth"
	"gitlab.com/reenue/graphql-server/services/contact_opportunity"
	"gitlab.com/reenue/graphql-server/services/forecast"
	"gitlab.com/reenue/graphql-server/services/playbook"
	"gitlab.com/reenue/graphql-server/services/task"
	"gitlab.com/reenue/graphql-server/services/user"
)

type Services struct {
	AuthService        auth.Service
	ContactOpportunity contact_opportunity.Service
	Forecast           forecast.Service
	Playbook           playbook.Service
	Tasks              task.Service
	User               user.Service
}

func getServices(db *gorm.DB, enforcer *casbin.Enforcer) *Services {
	contactOpportunityRepo := contact_opportunity.NewPostgresRepo(db)
	contactOpportunityService := contact_opportunity.NewService(contactOpportunityRepo)

	forecastRepo := forecast.NewPostgresRepo(db)
	forecastService := forecast.NewService(forecastRepo)

	playbookRepo := playbook.NewPostgresRepo(db)
	playbookService := playbook.NewService(playbookRepo)

	return &Services{
		AuthService:        newAuthService(enforcer),
		ContactOpportunity: contactOpportunityService,
		Playbook:           playbookService,
		Tasks:              newTaskRepo(db),
		Forecast:           forecastService,
		User:               newUserService(db),
	}
}

func newAuthService(enforcer *casbin.Enforcer) auth.Service {
	repo := auth.NewCasbinRepo(enforcer)

	return auth.NewService(repo)
}

func newTaskRepo(db *gorm.DB) task.Service {
	taskRepo := task.NewPostgresRepo(db)
	return task.NewService(taskRepo)
}

func newUserService(db *gorm.DB) user.Service {
	repo := user.NewMysqlRepo(db)

	return user.NewService(repo)
}
