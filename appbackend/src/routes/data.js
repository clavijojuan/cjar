const { Router } = require('express');
const { route } = require('express/lib/router');
const { validarJWT } = require('../middlewares/validar-jwt')
const { getData, getDomains, addData, updateData, getRowData, deleteRowData, getPhotos } = require('../controllers/data');
const router = Router();

router.get('/', validarJWT, getData);
router.get('/:table/:id', validarJWT, getRowData);
router.delete('/:table/:id', validarJWT, deleteRowData);
router.get('/:table/photos/:id', validarJWT, getPhotos);
router.get('/domains', validarJWT, getDomains);
router.post('/', validarJWT, addData);
router.put('/', validarJWT, updateData);


module.exports = router;