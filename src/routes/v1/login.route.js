const router = require('express').Router(),
    pageInfo = require('../../config/page.config').login;

router.all('/',function (req,res){
    res.render('login', pageInfo);
})

module.exports = router;