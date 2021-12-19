const express = require('express');
const router = express.Router();

const checkAuth = require('../middleware/check-auth');

router.get('/', checkAuth, (req, res, next) => {
    res.status(201).json({
        message: 'test created'
    });
});

router.get('/:parameterId', checkAuth, (req, res, next) => {
        let parameterId = req.params.parameterId;
        res.status(200).json({
        message: 'TestAPI GET',
        parameterId: parameterId
    });
});

router.delete('/:parameterId', checkAuth, (req, res, next) => {
    res.status(200).json({
        message: 'TestAPI DELETE',
        parameterId: req.params.parameterId
    });
});

module.exports = router;