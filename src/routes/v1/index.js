const express = require('express');
const router = express.Router();
const homeRoute = require('./home.route');
const registerRoute = require('./register.route');
const loginRoute = require('./login.route');
const pageInfo = require('../../config/page.config');
const cardRoute = require('./card.route');
const statusRoute = require('./status.route');
const certRoute = require('./cert.route');
const path = require('path');
const categoryModel = require('../../models/category.model');
const locationModel = require('../../models/location.model');
const centerModel = require('../../models/center.model');

router.use('/public',express.static(path.join(__dirname+'../../../'+'/public')));
router.use('/home',homeRoute);
router.use('/registration', registerRoute);
router.use('/vaccine-card', cardRoute);
router.use('/vaccine-status',statusRoute);
router.use('/certificate',certRoute);



router.get('/',function (req,res){
    res.redirect('/v1/home');
});

router.get('/faq',function(req,res){
    res.render('faq');
})

router.get('/category/:id',function (req,res){
    categoryModel.findSubSector(req.params.id)
        .then(data=>{
                //console.log(data.subSectors);
                res.json(data);
        })
        .catch(e=>{throw e;});
});
router.post('/location',function (req,res){
   //console.log(req.body);
    if(req.body.cityMun){
       locationModel.getWardUn(req.body.div,req.body.dis,req.body.ut,req.body.cityMun)
           .then(v=>{
                res.send(v);
           })
           .catch(e=> {throw e;});
   }
   else if(req.body.ut){
       locationModel.getCityMun(req.body.div,req.body.dis,req.body.ut)
           .then(v=>{
                   res.send(v);
           })
           .catch(e=> {throw e;});
   }
   else if(req.body.dis){
       locationModel.getUT(req.body.div,req.body.dis)
           .then(v=>{
                   res.send(v);
           })
           .catch(e=> {throw e;});
   }
   else if(req.body.div){
        locationModel.getDistrict(req.body.div)
            .then(v=>{
                    res.send(v);
            })
            .catch(e=> {throw e;});
    }
   else res.send({empty:true});
});

router.get('/center/:dis/:ut/:regType',function (req,res) {

    //console.log(req.params);
    //if reg is done with bcf then only send school centers
    if(req.params.regType === '1' || req.params.regType === '2'){
        centerModel.getCenterInUT(req.params.dis,req.params.ut)
            .then(v=>{
                res.send(v);
            })
            .catch(e=>{
                throw e;
            })
    }
});
module.exports = router;
/**
 * All routes goes from /v1/
 * currently single route to /v1/home
 */