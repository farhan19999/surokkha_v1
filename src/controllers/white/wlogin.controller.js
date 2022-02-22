const app = require('express').Router();
const wuserModel = require('../../models/wuser.model');


app.get('/',function (req,res){
    res.render('wLogin');
})

app.post('/process',function (req,res){
    //req.body will contain username and password
    let {username, password} = req.body;
    wuserModel.verifyLogin(username,password)
        .then(v=>{
            if(v){
                req.session.authenticated = true;
                req.session.inst_name = v.INSTITUTION_NAME;
                req.session.i_id = v.INSTITUTION_ID;
                req.session.saveUninitialized = true;
                res.redirect('/white/home');
            }
           else {
               res.redirect('/white/login');
            }
        })
        .catch(e=>{
            throw e;
        });
});


module.exports = app;