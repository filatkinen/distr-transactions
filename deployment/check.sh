#!/bin/bash

set -x

# Creating an order
curl -i -X POST http://localhost:8281/neworder  -d \
'{"order_id":0,"user_id":2,"payment":1,"notification":1,"created_at":"2023-11-01T16:35:39.645580261+03:00","approved_at":"2023-11-01T16:35:39.645580311+03:00","sum":10000,"items":[{"item_id":10,"quantity":2,"price":45},{"item_id":15,"quantity":1,"price":10}],"status":1,"detail":""}'
sleep 5

#Emulating mistakes in notification module
curl -i -X POST http://localhost:8285/set  -d '{"mistakes":100}'
# Creating an order
curl -i -X POST http://localhost:8281/neworder  -d \
'{"order_id":0,"user_id":2,"payment":1,"notification":1,"created_at":"2023-11-01T16:35:39.645580261+03:00","approved_at":"2023-11-01T16:35:39.645580311+03:00","sum":10000,"items":[{"item_id":10,"quantity":2,"price":45},{"item_id":15,"quantity":1,"price":10}],"status":1,"detail":""}'
sleep 5

#Emulating mistakes in payment module
curl -i -X POST http://localhost:8284/set  -d '{"mistakes":100}'
# Creating an order
curl -i -X POST http://localhost:8281/neworder  -d \
'{"order_id":0,"user_id":2,"payment":1,"notification":1,"created_at":"2023-11-01T16:35:39.645580261+03:00","approved_at":"2023-11-01T16:35:39.645580311+03:00","sum":10000,"items":[{"item_id":10,"quantity":2,"price":45},{"item_id":15,"quantity":1,"price":10}],"status":1,"detail":""}'
sleep 5

#Emulating mistakes in  warehouse module
curl -i -X POST http://localhost:8283/set  -d '{"mistakes":100}'
# Creating an order
curl -i -X POST http://localhost:8281/neworder  -d \
'{"order_id":0,"user_id":2,"payment":1,"notification":1,"created_at":"2023-11-01T16:35:39.645580261+03:00","approved_at":"2023-11-01T16:35:39.645580311+03:00","sum":10000,"items":[{"item_id":10,"quantity":2,"price":45},{"item_id":15,"quantity":1,"price":10}],"status":1,"detail":""}'

sleep 5