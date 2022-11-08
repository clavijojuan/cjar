import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { DataService } from '../../services/data.service';

@Component({
  selector: 'app-add',
  templateUrl: './add.component.html',
  styleUrls: ['./add.component.css']
})
export class AddComponent implements OnInit {

  table:string = '';
  addDataObject:any = {};
  files:any = [];

  tipo_planta_fk:any = [];
  locacion_fk:any = [];
  unidad_fk:any = [];
  familia_fk:any = [];
  genero_fk:any = [];
  especie_fk:any = [];

  constructor(
    private activeRoute: ActivatedRoute,
    private dataService: DataService,
    private router: Router,
    private toastr: ToastrService,
  ) { 
    this.dataService.getDomains().subscribe({
      next: (result:any) => {
        this.tipo_planta_fk = result.response['tipo_planta']
        this.locacion_fk = result.response['locacion']
        this.unidad_fk = result.response['unidad']
        this.familia_fk = result.response['familia']
        this.genero_fk = result.response['genero']
        this.especie_fk = result.response['especie']
      }
    })
  }

  ngOnInit(): void {
    this.activeRoute.params.subscribe({
      next: (params:any) => {
        const {tabla, id} = params;
        this.table = tabla;
        if(id) {
          this.addDataObject.id = id;
          this.dataService.getRowData(this.table, id).subscribe({
            next: (data:any) => {
              if(data.response.hasOwnProperty("fecha_coleccion")){
                data.response["fecha_coleccion"] = data.response["fecha_coleccion"].split("T")[0]
              }
              if(data.response.hasOwnProperty("fecha_colecta")){
                data.response["fecha_colecta"] = data.response["fecha_colecta"].split("T")[0]
              }
              this.addDataObject = {...data.response}
            }
          })
        };
      }
    })
  }

  evalProperties(obj:any){
    Object.keys(obj).forEach(key => {
      if(!obj[key]) delete obj[key];
    })
    return obj
  }

  setFiles(element:any){
    this.files = element.files
  }

  addData(form:NgForm):void {
    const obj = this.evalProperties({...form.value});
    if(this.addDataObject.hasOwnProperty("id")) Object.assign(obj, {id: this.addDataObject.id})
    const body = {table: this.table, data: obj}
    console.log(body, this.files)
    this.dataService.addOrUpdate(body, this.files, obj?.id).subscribe({
      next: (result:any) => {
        if(result.ok) this.goBack();
        this.toastr.success(result.msg, 'Éxito', {positionClass: 'toast-bottom-right'})
      },
      error: (result) => {
        this.toastr.error(result.msg, 'Error', {positionClass: 'toast-bottom-right'})
      }
    })
  }

  goBack(){
    this.router.navigate([`project/listado/${this.table}`])
  }

  validateField(arr:string[]){
    return arr.includes(this.table)
  }

}
