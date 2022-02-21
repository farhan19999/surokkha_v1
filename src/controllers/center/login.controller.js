var app = require('express').Router();
var centerModel = require('../../models/center.model');

app.get('/',function (req,res){
    res.render('centerLogin');
});

app.post('/',function (req,res){
    //console.log('Request sent for center login with '+ 'req.body :'+req.body +'\n'+'req.query :'+req.query);
    centerModel.validateLogin(req.body.username,req.body.password)
        .then(v=>{
            req.session.authenticated = true;
            req.session.saveUninitialized = true;
            req.session.center_name = v.CENTER_NAME;
            req.session.center_id = v.CENTER_ID;
            req.session.center_cap = v.DAILY_CAPACITY;
            //console.log(req.session);
            res.send({success : true});

        })
        .catch(e=>{throw e;})
});


module.exports = app;