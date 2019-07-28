'use strict';

const http = require('http');

const PORT = process.env.PORT || '3000';

const server = http.createServer((req, res) => {
  res.end('This server is working!');
});

server.listen(PORT, () => {
  console.log(`server running on ${PORT}`);
});
