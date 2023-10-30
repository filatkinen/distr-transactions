#!/bin/bash


#notification
curl -i -X POST http://localhost:8184/set  -d '{"mistakes":100}'
# payment
curl -i -X POST http://localhost:8183/set  -d '{"mistakes":100}'
# warehouse
curl -i -X POST http://localhost:8182/set  -d '{"mistakes":100}'