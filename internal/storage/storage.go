package storage

import (
	"context"
	"github.com/jackc/pgx/v5/pgxpool"
	"log"
)

type Database struct {
	db *pgxpool.Pool
}

func New(connString string, maxConn, minConn int) (*Database, error) {
	db, err := newPool(connString, maxConn, minConn)
	if err != nil {
		log.Printf("error creating pgxpool %s", err)
		return nil, err
	}
	return &Database{db: db}, nil
}

func newPool(connString string, maxConn, minConn int) (*pgxpool.Pool, error) {
	poolConfig, err := pgxpool.ParseConfig(connString)
	if err != nil {
		log.Fatalln("Unable to parse DATABASE_URL:", err)
	}
	poolConfig.MaxConns = int32(maxConn)
	poolConfig.MinConns = int32(minConn)
	db, err := pgxpool.NewWithConfig(context.Background(), poolConfig)

	if err != nil {
		return nil, err
	}

	err = db.Ping(context.Background())
	if err != nil {
		db.Close()
		return nil, err
	}
	return db, nil
}

func (d *Database) Close() error {
	d.db.Close()
	return nil
}

//func (d *Database) SimpleQueryReturnRandomUserName() (username string, err error) {
//	defer func() {
//		if e := recover(); e != nil {
//			err = fmt.Errorf("recoverd from panic:%v", e)
//		}
//	}()
//
//
//	var numberUsers int
//	err = d.db.QueryRow(context.Background(), `select count(username) from users`).Scan(&numberUsers)
//	if err != nil {
//		return "", err
//	}
//	if numberUsers == 0 {
//		return "", errors.New("0 users")
//	}
//	s1 := rand.NewSource(time.Now().UnixNano())
//	r1 := rand.New(s1)
//
//	userOffset := r1.Intn(numberUsers)
//
//	query := `select username from users OFFSET $1 limit 1`
//	err = d.db.QueryRow(context.Background(), query, userOffset).Scan(&username)
//	if err != nil {
//		return "", err
//	}
//	return username, nil
//}
