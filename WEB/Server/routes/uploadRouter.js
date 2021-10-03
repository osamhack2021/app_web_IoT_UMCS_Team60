const router = require('express').Router();
const multer = require('multer');

const doomDrawingUpload = multer({ dest: '../uploads/doomDrawing/' });
const profileUpload = multer({ dest: '../uploads/profile/' });

router.post('/doomDrawing', doomDrawingUpload.single('image'), (req, res) => {
    const { fieldname, originalname, encoding, mimetype, destination, filename, path, size } = req.file
    const { name } = req.body;

    res.json(req.file);
});

router.get('/doomDrawing/:name', (req, res) => {
    res.sendFile(`/uploads/doomDrawing/${req.params.name}`, { root: __dirname + '/../' });
});


router.post('/profile', profileUpload.single('image'), (req, res) => {
    const { fieldname, originalname, encoding, mimetype, destination, filename, path, size } = req.file
    const { name } = req.body;

    res.json(req.file);
});

router.get('/profile/:name', (req, res) => {
    res.sendFile(`/uploads/profile/${req.params.name}`, { root: __dirname + '/../' });
});

module.exports = router;