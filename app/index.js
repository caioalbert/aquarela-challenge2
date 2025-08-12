const apm = require('elastic-apm-node').start({
  serviceName: 'example-app',
  serverUrl: 'http://<your-apm-server>:8200',
});

const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send('Hello, Elastic APM!');
});

app.listen(3000, () => {
  console.log('App running on port 3000');
});
