var app = require('express').Router();
var session = require('express-session');
var homeController = require('../../controllers/white/whome.controller');
var loginController = require('../../controllers/white/wlogin.controller');
var dataEntryController = require('../../controllers/white/wDataEntry.controller');

app.use(session({
    name : 'white.sid',
    secret : 'mad baby',
    saveUninitialized : false,
    resave : false,
    cookie : { maxAge : 1000*60*5 }
}));

app.use('/home',homeController);
app.use('/login',loginController);
app.use('/entry',dataEntryController);

app.get('/',function (req,res){
   if(req.session.authenticated)res.redirect( '/white/home');
   else res.redirect('/white/login');
});

app.get('/sign_out',function (req,res){
    if(req.session.authenticated)
    {
        req.session.destroy();
    }
    res.redirect('/white/login');
});


module.exports = app;