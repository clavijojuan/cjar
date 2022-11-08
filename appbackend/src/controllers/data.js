let { response } = require('express');
const pool = require('../database');
const { saveFile, getFiles } = require('../helpers/files')

const getData = async (req, res) => {
    try {
        let sql;
        const { table } = req.query;
        switch (table) {
            case 'familia':
                sql = 'select id, nombre from familia;';
                break;
            case 'locacion':
                sql = 'select id, latitud, longitud, nombre, pais from locacion;';
                break;
            case 'genero':
                sql = `
                    select genero.id, genero.nombre, familia.nombre as familia
                    from genero
                    join familia on familia.id = genero.familia_fk;
                `;
                break;
            case 'especie':
                sql = `
                    select especie.id, especie.nombre, genero.nombre as genero
                    from especie
                    join genero on genero.id = especie.genero_fk;
                `;
                break;
            case 'localidad':
                sql = 'select * from piezas.localidad;';
                break;
            case 'unidad':
                sql = 'select * from plantas.unidad;';
                break;
            case 'tipo_planta':
                sql = 'select * from plantas.tipo_planta;';
                break;
            case 'animal':
                sql = `
                    select animal.id, animal.nombre, animal.repositorio, 
                    animal.fecha_colecta, animal.identificador_alterno,
                    especie.nombre as especie, genero.nombre as genero, 
                    convenio.nombre as convenio,
                    familia.nombre as familia, locacion.nombre as locacion
                    from piezas.animal as animal
                    left join especie on animal.especie_fk = especie.id
                    left join genero on animal.genero_fk = genero.id
                    left join piezas.convenio as convenio on animal.convenio_fk = convenio.id
                    left join familia on animal.familia_fk = familia.id
                    left join locacion on animal.locacion_fk = locacion.id;
                `;
                break;
            case 'planta':
                sql = `
                    select planta.id, planta.fecha_coleccion, planta.importancia, planta.medidas,
                    planta.foto_fk,
                    especie.nombre as especie, genero.nombre as genero,
                    familia.nombre as familia, unidad.nombre as unidad, locacion.nombre as locacion,
                    tipo_planta.nombre as tipo_planta
                    from plantas.planta as planta
                    left join especie on planta.especie_fk = especie.id
                    left join genero on planta.genero_fk = genero.id
                    left join familia on planta.familia_fk = familia.id
                    left join plantas.unidad as unidad on planta.unidad_fk = unidad.id
                    left join locacion on planta.locacion_fk = locacion.id
                    left join plantas.tipo_planta as tipo_planta on planta.tipo_planta_fk = tipo_planta.id;
                `;
                break;
        }
        const query = await pool.query(sql);
        return res.json({
            ok: true,
            status: 200,
            response: query.rows
        })
    } catch (error) {
        return res.json({
            ok: false,
            status: 400,
            msg: 'No se encontraron resultados'
        })
    }
}

const getDomains = async (req, res) => {
    try {
        let obj = {};
        const stringArr = [
            'plantas.tipo_planta',
            'locacion',
            'plantas.unidad',
            'familia',
            'genero',
            'especie',
        ]
        for (const table of stringArr){
            const sql = `select * from ${table}`
            const query = await pool.query(sql)
            const property = table.replace("plantas.", "")
            obj[property] = query.rows
        }
        return res.json({
            ok: true,
            status: 200,
            response: obj
        })
    } catch (error) {
        return res.json({
            ok: false,
            status: 400,
            msg: 'No se encontraron resultados'
        })
    }
}

const validateTable = (table) => {
    if(['tipo_planta', 'unidad', 'planta', 'foto'].includes(table)) return `plantas.${table}`
    else if(['convenio', 'localidad', 'animal'].includes(table)) return `piezas.${table}`
    else return `${table}`
}

const addData = async (req, res) => {
    try {
        let files;
        let {table, data} = JSON.parse(req.body.body);
        if(req.hasOwnProperty('files')) files = req.files.files
        table = validateTable(table);
        const keys = [...Object.keys(data)].map(key => `${key}`)
        const values = [...Object.values(data)].map(value => `'${value}'`)
        const sql = `
            insert into ${table}(${keys}) values (${values})
            returning id
        `;
        const result = await pool.query(sql);
        if(result.rows.length > 0){
            if(files){
                try {
                    const route = await saveFile(files, `${result.rows[0].id}/`);
                    const idRoute = await pool.query(`
                        insert into plantas.foto(ruta) values('${route}')
                        returning id
                    `);
                    await pool.query(`
                        update plantas.planta
                        set foto_fk = ${idRoute.rows[0].id}
                        where id = ${result.rows[0].id}
                    `);

                } catch (error) {
                    console.log(error);
                    return res.json({
                        ok: false,
                        status: 400,
                        msg: 'No se pudo añadir los archivos'
                    })
                }
            }
        }
        return res.json({
            ok: true,
            status: 200,
            msg: 'Registro añadido correctamente'
        })
    } catch (error) {
        console.log(error)
        return res.json({
            ok: false,
            status: 400,
            msg: 'No se pudo añadir el registro'
        })
    }
} 

const updateData = async (req, res) => {
    try {
        let { table, data } = req.body
        const { id } = data;
        delete data.id;
        table = validateTable(table);
        let sql = `
            update ${table}
        `;
        for (const key of Object.keys(data)) {
            sql += `set ${key} = '${data[key]}'`;
        }
        sql += `where id = ${id};`;
        await pool.query(sql);
        return res.json({
            ok: true,
            status: 200,
            msg: 'Registro actualizado correctamente'
        })
    } catch (error) {
        console.log(error)
        return res.json({
            ok: false,
            status: 400,
            msg: 'No se pudo realizar la actualización'
        })
    }
}

const getRowData = async (req, res) => {
    try {
        let { table, id } = req.params
        table = validateTable(table);
        const sql = `
            select * from ${table}
            where id = ${id}
        ;`;
        const query = await pool.query(sql);
        return res.json({
            ok: true,
            status: 200,
            response: query.rows[0]
        })
    } catch (error) {
        return res.json({
            ok: false,
            status: 400,
            msg: 'No se pudo realizar la consulta'
        })
    }
}

const deleteRowData = async (req, res) => {
    try {
        let sql;
        let { table, id } = req.params
        switch (table) {
            case 'familia':
                sql = `
                    DELETE FROM plantas.planta  as planta
                    WHERE planta.familia_fk = ${id};
                    
                    DELETE FROM genero 
                    WHERE genero.familia_fk = ${id};
                    
                    DELETE FROM piezas.animal as animal
                    WHERE animal.familia_fk = ${id};

                    delete from familia
                    where id = ${id};
                `;
                break;
            case 'locacion':
                sql = `
                    DELETE FROM plantas.planta  as planta 
                    WHERE planta.locacion_fk = ${id};

                    DELETE FROM piezas.animal as animal 
                    WHERE animal.locacion_fk = ${id};

                    delete from locacion
                    where id = ${id};
                `;
                break;
            case 'genero':
                sql = `
                    delete from plantas.planta  as planta 
                    where panta.especie_fk = (
                        select id from especie
                        where especie.genero_fk = ${id};
                    );

                    delete from piezas.animal as animal 
                    where animal.especie_fk = (
                        select id from especie
                        where especie.genero_fk = ${id};
                    );

                    DELETE FROM especie 
                    WHERE especie.genero_fk = ${id};

                    DELETE FROM piezas.animal as animal  
                    WHERE animal.genero_fk = ${id};

                    DELETE FROM plantas.planta  as planta  
                    WHERE planta.genero_fk = ${id};

                    delete from genero
                    where id = ${id};
                `;
                break;
            case 'especie':
                sql = `
                    delete from plantas.planta  as planta 
                    where planta.especie_fk = ${id};

                    delete from piezas.animal as animal  
                    where animal.especie_fk = ${id};    

                    delete from especie
                    where id = ${id};
                `;
                break;
            case 'convenio':
                sql = `
                    delete from piezas.animal as animal  
                    where animal.convenio_fk = ${id};    

                    delete from piezas.convenio as convenio
                    where id = ${id};
                `;
                break;
            case 'localidad':
                sql = `
                    delete from piezas.localidad
                    where id = ${id};
                `;
                break;
            case 'unidad':
                sql = `
                    delete from plantas.planta  as planta 
                    where planta.unidad_fk = ${id};    

                    delete from plantas.unidad
                    where id = ${id};
                `;
                break;
            case 'tipo_planta':
                sql = `
                    delete from plantas.planta as planta 
                    where planta.tipo_planta_fk = ${id};    

                    delete from plantas.tipo_planta
                    where id = ${id};
                `;
                break;
            case 'animal':
                sql = `
                    delete from piezas.animal
                    where id = ${id};
                `;
                break;
            case 'planta':
                sql = `
                    delete from plantas.planta
                    where id = ${id};
                `;
                break;
        }

        const query = await pool.query(sql);
        return res.json({
            ok: true,
            status: 200,
            msg: 'Registro borrado satisfactoriamente'
        })
    } catch (error) {
        console.log(error)
        return res.json({
            ok: false,
            status: 400,
            msg: 'No se pudo borrar el recurso'
        }) 
    }
}

const getPhotos = async (req, res) => {
    try {
        const { id } = req.params
        const result = await pool.query(`
            select ruta from plantas.foto
            where id = ${id}
        `);
        const files = await getFiles(result.rows[0].ruta)
        if(files.length > 0) {
            return res.json({
                ok: true,
                status: 200,
                response: files
            }) 
        }
        return res.error(400) 
    } catch (error) {
        return res.json({
            ok: false,
            status: 400,
            msg: 'No se pudo consultar el recurso'
        }) 
    }
}

module.exports = { getData, getDomains, addData, updateData, getRowData, deleteRowData, getPhotos };