var userModel = require('../models/user.model');
const categoryModel = require('../models/category.model');
const nidModel = require('../models/whitelist.nid.model');
const bcfModel  = require('../models/whitelist.bcf.model');
const locationModel = require('../models/location.model');

verification = function (req,res,next){
    let data = {};
    data.dob = req.body.dob;
    //verify user
    if(req.body.regMethod === '1'){
        data.nid = req.body.nid;
        let category ={};
        category.sector_id = req.body.sector_id;
        if(req.body.sub_sector_id)category.sub_sector_id = req.body.sub_sector_id;
        userModel.findUser(data.nid,'NID',data.dob,'')
            .then(value => {
                if(value){
                    req.body.verified = 2;
                    next();
                }
                else {
                    categoryModel.findCategoryId(category)
                        .then(v=>{
                            data.category_id = v;
                            nidModel.verifyPreReg(data)
                                .then(n=>{
                                    //console.log(n);
                                    if(n){
                                        req.body.name = n;
                                        req.body.verified = 1;
                                    }
                                    else req.body.verified = 0;
                                    next();
                                })
                                .catch(e=>{next(e);});
                        })
                        .catch(e=>{console.log('Nid Verification error')});
                }
            })
            .catch(e=>{
                console.log('Error in finding user');
                console.log(e);
            });

    }
    else if(req.body.regMethod === '2'){
        data.bcf  = req.body.bcf;
        userModel.findUser(data.nid,'NID',data.dob,'')
            .then(value => {
                if(value){
                    req.body.verified = 2;
                    next();
                }
                else {
                    bcfModel.verifyPreReg(data)
                        .then(n=>{
                            if(n){
                                req.body.name = n;
                                req.body.verified = 1;
                            }
                            else req.body.verified = 0;
                            next();
                        })
                        .catch(e=>{
                            console.log(e);
                            next(e);
                        });
                }
            })
            .catch(e=>{
                console.log('Error in finding user');
                console.log(e);
            });
    }
    else next();
};


registerUser = function (req,res,next) {
   let user = {regType : req.body.regType, fn : req.body.fn, ln : req.body.ln,pwd:req.body.pwd, nid: req.body.nid, bcf : req.body.bcf, dob: req.body.dob, ph_num: req.body.ph_num, email: req.body.email, hbp : req.body.hbp, kd: req.body.kd, resp : req.body.resp, prev_cov: req.body.prev_cov, cancer: req.body.cancer, dbts: req.body.dbts, prefCenter:req.body.prefCenter};
    locationModel.getLocationId(req.body.div, req.body.dist, req.body.ut, req.body.cityMun, req.body.unw)
        .then(id=>{
            user.location_id = id;
            //console.log('found location id : ' + id);
            let category ={};
            category.sector_id = req.body.sector_id;
            if(req.body.sub_sector_id)category.sub_sector_id = req.body.sub_sector_id;
            user.category_id = categoryModel.findCategoryId(category)
                .then(v=>{
                    //console.log('found category id :' + v);
                    user.category_id = v;
                    req.body.user = user;
                    next();
                })
                .catch(e=>{throw next(e);});
        })
        .catch(e=>{throw next(e);});
};

module.exports = {
  registerUser,
  verification
};