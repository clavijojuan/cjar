import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ProjectRoutingModule } from './project-routing.module';
import { HomeComponent } from './pages/home/home.component';
import { MaterialModule } from '../material/material.module';
import { ListadoComponent } from './pages/listado/listado.component';
import { AddComponent } from './pages/add/add.component';
import { FormsModule } from '@angular/forms';
import { AttPipe } from './pipes/att.pipe';
import { TableNamePipe } from './pipes/table-name.pipe';

@NgModule({
  declarations: [
    HomeComponent,
    ListadoComponent,
    AddComponent,
    AttPipe,
    TableNamePipe
  ],
  imports: [
    CommonModule,
    FormsModule,
    ProjectRoutingModule,
    MaterialModule,
  ]
})
export class ProjectModule { }
