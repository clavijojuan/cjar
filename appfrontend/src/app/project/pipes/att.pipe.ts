import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'att'
})
export class AttPipe implements PipeTransform {
  transform(value:string): string {
    return (value === 'id') ? 'Id' : 
           (value === 'nombre') ? 'Nombre' : 
           (value === 'latitud') ? 'Latitud' : 
           (value === 'longitud') ? 'Longitud' : 
           (value === 'pais') ? 'País' : 
           (value === 'familia') ? 'Familia' : 
           (value === 'genero') ? 'Genero' : 
           (value === 'especie') ? 'Especie' :
           (value === 'unidad') ? 'Unidad' :
           (value === 'locacion') ? 'Locación' : 
           (value === 'tipo_planta') ? 'Tipo de planta' : 
           (value === 'fecha_coleccion') ? 'Fecha de colección' : 
           (value === 'importancia') ? 'Importancia' : 
           (value === 'medidas') ? 'Medidas' : 
           (value === 'polaridad') ? 'Polaridad' : 
           (value === 'altura') ? 'Altura' : 
           (value === 'comentario') ? 'Comentario' : 
           (value === 'repositorio') ? 'Repositorio' : 
           (value === 'fecha_colecta') ? 'Fecha de colecta' : 
           (value === 'identificador_alterno') ? 'Identificador alterno' : value
  }

}
