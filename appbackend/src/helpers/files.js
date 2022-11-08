const path = require('path');
const fs = require('fs');
const { v4: uuidv4 } = require('uuid');

const saveFile = ( files, folder ='') => {
    return new Promise((resolve, reject) => {
        const relativeUrl = path.join('../src/storage/data/uploads/', folder);
        const url = path.join(path.dirname(__dirname), relativeUrl);
        for (const file of files) {
            const nameFileSplit = file.name.split('.');
            const extension = nameFileSplit[ nameFileSplit.length - 1];
            const nameTemp = uuidv4() + '.' +extension;
            const uploadPath = path.join(path.dirname(__dirname), '../src/storage/data/uploads/', folder, nameTemp);
    
            if(!fs.existsSync(url)) {
                fs.mkdirSync(url, { recursive: true });
            }
    
            file.mv(uploadPath, (err) => {
                if(err){
                    reject(err)
                }
            });
        }
        resolve(relativeUrl);
    })
}

function promiseAllP(items, block) {
    var promises = [];
    items.forEach(function(item,index) {
        promises.push( function(item,i) {
            return new Promise(function(resolve, reject) {
                return block.apply(this,[item,index,resolve,reject]);
            });
        }(item,index))
    });
    return Promise.all(promises);
}

const getFiles = (dirname) => {
    dirname = path.join(path.dirname(__dirname), dirname);
    return new Promise((resolve, reject) => {
        fs.readdir(dirname, function(err, filenames) {
            if (err) return reject(err);
            promiseAllP(filenames,
            (filename,index,resolve,reject) =>  {
                fs.readFile(path.resolve(dirname, filename), 'utf-8', function(err, content) {
                    if (err) return reject(err);
                    return resolve({filename: filename, contents: content});
                });
            })
            .then(results => {
                return resolve(results);
            })
            .catch(error => {
                return reject(error);
            });
        });
  });
}


module.exports = { saveFile, getFiles }