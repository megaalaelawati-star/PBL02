// routes/kasirRoutes.js

const express = require('express');
const router = express.Router();
const kasirController = require('../controllers/kasirController');

router.post('/', kasirController.createKasir);
router.get('/', kasirController.getAllKasir);
router.get('/:id', kasirController.getKasirById);
router.put('/:id', kasirController.updateKasir);
router.delete('/:id', kasirController.deleteKasir);

module.exports = router;