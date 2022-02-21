var app = require('express').Router();
var loginController = require('../../controllers/center/login.controller');
var homeController = require('../../controllers/center/centerHome.controller');
var fileController = require('../../controllers/center/centerDataFile.controller');
var session = require('express-session');

app.use(session({
    name : 'center.sid',
    secret : 'mad baby',
    saveUninitialized : false,
    resave : false,
    cookie : { maxAge : 1000*60*5 }
}));


app.get('/',function (req,res){
    if(req.session.authenticated)res.redirect('/center/home');
    else res.redirect('/center/login');
})
app.use('/login',loginController);
app.use('/home',homeController);
app.use('/fileUpload',fileController);


module.exports = app;