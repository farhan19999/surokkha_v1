var route = require('express').Router();

route.get('/',function(req,res){
    res.render('vaccine-status');
});

module.exports = route;