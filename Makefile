generate:
	go run github.com/99designs/gqlgen generate

migrate:
	docker-compose exec app go run main.go migrate

migration:
	migrate create -dir database/migrations -ext sql $(name)

fresh:
	docker-compose exec app go run main.go migrate --fresh --seed