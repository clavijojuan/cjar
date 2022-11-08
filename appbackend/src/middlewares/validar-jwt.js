const jwt = require('jsonwebtoken');

const validarJWT = (req, res, next) => {
    const token = req.header('x-token');
    if (!token) {
        return res.status(401).json({
            ok: false,
            msg: 'No hay token'
        });
    }
    try {
        const { id, usuario, contrasena, id_rol } = jwt.verify(token, process.env.SECRET_JWT_SEED)
        req.id = id;
        req.usuario = usuario;
        req.contrasena = contrasena;
        req.id_rol = id_rol;
    } catch (error) {
        return res.status(401).json({
            ok: false,
            msg: 'Token no valido'
        });
    }
    next();
}

module.exports = {
    validarJWT
}