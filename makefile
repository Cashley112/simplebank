postgres:
	docker run --name cnr-postgres -p 5432:5432 -e POSTGRES_USER=cnr -e POSTGRES_PASSWORD=secret -d postgres:14-alpine

createdb:
	docker exec -it cnr-postgres createdb --username=cnr --owner=cnr simple_bank

dropdb:
	docker exec -it cnr-postgres dropdb simple_bank -U cnr

migrateup:
	migrate -path db/migration -database "postgresql://cnr:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://cnr:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

.PHONY: postgres createdb dropdb migrateup migratedown sqlc