const express = require('express');
const app = express();
const router = require('./routes/v1/index');
const appConfig  = require('./config/app.config');
const path = require('path');
const admin = require('./routes/admin/index');
var vhost = require('vhost');
const wRouter = require('./routes/white/index');
const cRouter = require('./routes/center/index');


app.set('port',process.env.PORT || 3000);
app.set('views', path.join(__dirname,'/views'));

appConfig.setEngine(app);
appConfig.setMiddleware(app);


app.use(vhost('admin.*',admin));
app.use('/white',wRouter);
app.use('/center',cRouter);
app.use('/v1',router);
app.get( '/',function(req,res,next){
    res.redirect('/v1');
});
app.use(function(err,req,res,next){
    console.log(err);
    //res.render('error');
    res.send('Server Error');
    next();
})
app.use(function (req,res){
    res.status(404);
    res.type('text/plain');
    res.send('404 - Not found');
})
module.exports = app;
