const express = require('express');

const router = express.Router();

router.get('/', (req, res) => {
    res.json({page:'index'});
});

module.exports = router;