const jwt = require('jsonwebtoken');

const generarJWT = (id, usuario, contrasena, id_rol) => {

    const payload =  { id, usuario, contrasena, id_rol };

    return new Promise((resolve, reject) => {
        jwt.sign(payload, process.env.SECRET_JWT_SEED, {
            expiresIn: '24h'
        }, (err, token) => {
            if(err) {
                reject('Error generando el token');
                throw err;
            } else {
                resolve(token);
            }
        })
    });
}

module.exports = {
    generarJWT
}