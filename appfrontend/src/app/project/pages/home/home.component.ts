import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { first } from 'rxjs';
import { AuthService } from 'src/app/auth/services/auth.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {

  auth: any = {};
  projects:any = []

  constructor(
    private router:Router,
    private authService:AuthService
  ) {
  }

  ngOnInit(): void {
    this.auth = this.authService.getAuth;
    this.router.navigate(['project']);
    this.generateProjectsConfig();
  }

  generateProjectsConfig(): void {
    this.projects = [
      {
        label: 'Proyecto plantas',
        icon: 'grass',
        visible: this.auth?.permisos?.acceso_plantas,
        children: [
          {
            label: 'Plantas',
            routerLink: './listado/planta'
          },
          {
            label: 'Tipo de planta',
            routerLink: './listado/tipo_planta'
          },
          {
            label: 'Unidad',
            routerLink: './listado/unidad'
          },
        ],
        
      },
      {
        label: 'Proyecto Piezas',
        icon: 'pets',
        visible: this.auth?.permisos?.acceso_piezas,
        children: [
          {
            label: 'Localidad',
            routerLink: './listado/localidad'
          },
          {
            label: 'Animal',
            routerLink: './listado/animal'
          },
        ],
        
      },
      {
        label: 'Tablas maestras',
        icon: 'table_chart',
        visible: true,
        children: [
          {
            label: 'Locación',
            routerLink: './listado/locacion'
          },
          {
            label: 'Familia',
            routerLink: './listado/familia'
          },
          {
            label: 'Genero',
            routerLink: './listado/genero'
          },
          {
            label: 'Especie',
            routerLink: './listado/especie'
          },
        ],
        
      },
    ]
  }

  clearRoute(){
    this.router.navigate(['project'])
  }


  logout() {
    this.authService.logout();
    this.router.navigate(['auth'])
  }

}
