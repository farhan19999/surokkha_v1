const express = require('express');
const router = express.Router();
const controller = require('../../controllers/home.controller');

router
    .route('/')
        .get(controller.getHomePage);
module.exports = router;