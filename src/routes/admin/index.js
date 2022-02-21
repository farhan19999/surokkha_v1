let admin   = require('express').Router();
var adminController = require('../../controllers/admin.controller');
var tableRoute = require('./tables');
admin.use('/tables',tableRoute);

admin.get('/',function (req,res)
{
    res.render('admin_home',{layout:'admin_layout',title:'Admin Home'});
});


module.exports = admin;

