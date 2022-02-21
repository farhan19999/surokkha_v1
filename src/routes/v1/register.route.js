const express = require('express');
const router = express.Router();
const pageInfo = require('../../config/page.config').register;
const controller = require('../../controllers/register.controller');
const categoryModel = require('../../models/category.model');
const nidModel = require('../../models/whitelist.nid.model');
const locationModel = require('../../models/location.model');
const userModel = require('../../models/user.model');
router.get('/',function (req,res){

    categoryModel.loadAllCategory()
        .then(d=>{
            locationModel.getAllDivision()
                .then(div=>{
                    res.render('registration',{category:d.sector,division:div});
                })
                .catch(e=>{throw e;});
        })
        .catch(e=> {throw e;});
});
router.use('/s/1',controller.verification);
router.post('/s/1',function (req,res){
    //find name
    if(req.body.verified === 1) {
        res.send({success:true, name : req.body.name});
    }
    else{
        console.log('User couldn\'t be verified');
        res.send({success:false});
    }
});
router.post('/s/2',controller.registerUser,function (req,res){
    //register user
    console.log(req.body.user);
    userModel.registerUserInDB(req.body.user)
        .then(v=>{
            res.send({success:true});
        })
        .catch(e=>{
            throw e;
        });
})

module.exports = router;