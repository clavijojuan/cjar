const { Router } = require('express');
const { route } = require('express/lib/router');
const { validarJWT } = require('../middlewares/validar-jwt')
const { login, revalidarToken } = require('../controllers/auth');
const router = Router();


router.post('/', login)
router.get('/renew', validarJWT, revalidarToken);


module.exports = router;