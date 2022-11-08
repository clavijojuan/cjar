import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'tableName'
})
export class TableNamePipe implements PipeTransform {

  transform(value:string): string {
    return (value === 'familia')     ? 'Familia'        : 
           (value === 'locacion')    ? 'Locación'       : 
           (value === 'genero')      ? 'Género'         : 
           (value === 'especie')     ? 'Especie'        : 
           (value === 'convenio')    ? 'Convenio'       : 
           (value === 'localidad')   ? 'Localidad'      : 
           (value === 'unidad')      ? 'Unidad'         : 
           (value === 'animal')      ? 'Animal'         :
           (value === 'planta')      ? 'Planta'         :
           (value === 'tipo_planta') ? 'Tipo de planta' : value
  }

}
