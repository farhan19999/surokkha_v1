var route = require('express').Router();
var userModel = require('../../models/user.model');

route.get('/',function(req,res){
    res.render('vaccine-status');
});

route.post('/getStatus/:type',function (req,res){
    //console.log(req.body);
    userModel.findUser(req.body.uid,req.params.type,req.body.dob,req.body.pwd)
        .then(v=>{
            if(v){
                userModel.findUserHistory(v.REGISTRATION_ID)
                    .then(history=>{
                        res.send({success:true, data:history});
                    })
                    .catch(e=>{
                        console.log('error in finding history....')
                        res.send({success:false,msg:e});
                    });
            }
            else res.send({success:false, msg:'Couldn\'t find the user' });
        })
        .catch(e=>{
            console.log('error in verification....')
            res.send({success:false,msg:e});
        });
});

module.exports = route;