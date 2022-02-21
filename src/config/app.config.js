const path = require('path');
const express = require('express');
const handlebars = require('express3-handlebars')
    .create({
        defaultLayout: 'main',
        layoutsDir:  path.join(__dirname,'../','/views/layouts'),
        partialsDir: path.join(__dirname,'../','/views/partials')
    });

exports.setEngine = function (app){
    app.engine('handlebars', handlebars.engine);
    app.set('view engine', 'handlebars' );
}
exports.setMiddleware = function (app){
    app.use(express.urlencoded({extended : true}));
    app.use(express.json());
}


