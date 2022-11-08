const { generarJWT } = require('../helpers/jwt');
let { response } = require('express');
const pool = require('../database');

const login = async (req, res) => {
    try {
        const { usuario, contrasena } = req.body;
        const sql = `
            select usuario.id, usuario.usuario, rol.id as id_rol,
            rol.nombre as rol, rol.acceso_plantas, rol.acceso_piezas 
            from usuario
            join rol on rol.id = usuario.rol_fk
            where usuario.usuario = '${usuario.trim()}' 
            and usuario.contrasena = crypt('${contrasena.trim()}',contrasena);
        `;

        const query = await pool.query(sql);
        if(query.rows.length > 0) {
            const { id, usuario, id_rol, rol } = query.rows[0];
            const permisos = {
                acceso_plantas: query.rows[0].acceso_plantas,
                acceso_piezas: query.rows[0].acceso_piezas,
            };
            const token = await generarJWT(id, usuario, contrasena, id_rol);
            const response =  {
                id,
                usuario,
                rol,
                permisos,
            }
            return res.json({
                ok: true,
                status: 200,
                response,
                token
            })
        }
        else {
            return res.json({
                ok: false,
                status: 400,
                msg: 'No se encontró el usuario'
            })
        }
    } catch (error) {
        console.log(error)
    }
}

const getRol = async (id_rol) => {
    const query = await pool.query(`
        select rol.nombre as rol, rol.acceso_plantas, rol.acceso_piezas
        from rol
        where rol.id = '${id_rol}'
    `);
    const obj = {
        rol: query.rows[0].rol,
        permisos : {
            acceso_plantas: query.rows[0].acceso_plantas,
            acceso_piezas: query.rows[0].acceso_piezas,
        }
    }
    return obj
}

const revalidarToken = async (req, res) => {
    const {id, usuario, contrasena, id_rol} = req
    const token = await generarJWT(id, usuario, contrasena, id_rol);
    const {rol, permisos} = await getRol(id_rol);
    const response =  {
        id,
        usuario,
        rol,
        permisos,
    }
    return res.json({
        ok: true,
        msg: 'token revalidado',
        token,
        response
    });
}

module.exports = { login, revalidarToken };