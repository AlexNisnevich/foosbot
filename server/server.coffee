http  = require 'http'
mongo = require 'mongodb'

server_port = 0xf005

mongo_host = '127.0.0.1'
mongo_port = 0xf006
mongo_db   = 'foosbot'
mongo_coll = 'matches'

server = new mongo.Server mongo_host, mongo_port, {}
db     = new mongo.Db mongo_db, server

db.open (err, db) ->
  db.collection mongo_coll, (err, collection) ->
    http.createServer (req, res) ->
      if req.method == 'POST'
        body = ''
        req.on 'data', (data) ->
          body += data
        req.on 'end', () ->
          console.log body
          try
            match = JSON.parse(body)
            collection.insert JSON.parse(body)
          catch error
            console.log error
      else
        console.log "other request"
      res.writeHead 200, 'Content-Type': 'text/plain'
      res.end 'Hello World\n'
    .listen server_port
    console.log "Foosbot Server running on port #{server_port}"
