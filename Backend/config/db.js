const mysql = require('mysql2/promise');

const connection = mysql.createPool({
    host: 'db',
    user: 'root',
    password: 'root',
    database: 'esd_database'
})

module.exports = connection;