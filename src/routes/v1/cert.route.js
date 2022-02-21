var route = require('express').Router();

route.get('/',function(req,res){
    res.render('certificate');
});

module.exports = route;