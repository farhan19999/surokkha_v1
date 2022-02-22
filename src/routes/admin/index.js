let admin   = require('express').Router();
var adminController = require('../../controllers/admin.controller');
var tableRoute = require('./tables');

var session = require('express-session');

admin.use(session({
    name : 'admin.sid',
    secret : 'boss baby ',
    saveUninitialized : false,
    resave : false,
    cookie : { maxAge : 1000*60*5 }
}));

admin.use('/login',adminController);
admin.use('/tables',tableRoute);

admin.get('/',function (req,res)
{
    if(req.session.authenticated === 1){
        res.render('admin_home',{layout:'admin_layout',title:'Admin Home'});
    }
    else res.redirect('/login');
});


module.exports = admin;

