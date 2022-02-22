const router = require('express').Router();

router.get('/',function (req,res){
    if(req.session.authenticated)
    {
        res.redirect('/');
    }
    else {
        res.render('admin_login',{layout:'admin_layout'});
    }
});
router.post('/', function (req,res){
    console.log(req.body);
    if(req.session.authenticated)
    {
        res.redirect('/');
    }
    else {
        if(req.body.username === 'admin' && req.body.password === 'admin'){
            req.session.authenticated = 1;
            req.session.saveUninitialized = true;
            res.send({success:true});
        }
        else {
            res.send({success:false, msg:'Authentication failed'});
        }
    }
})

module.exports = router;
