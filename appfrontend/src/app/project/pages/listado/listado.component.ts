import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';

import {MatTableDataSource} from '@angular/material/table';
import { MatSort, Sort } from '@angular/material/sort';
import { LiveAnnouncer } from '@angular/cdk/a11y';
import { MatPaginator } from '@angular/material/paginator';

import { DataService } from '../../services/data.service';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'app-listado',
  templateUrl: './listado.component.html',
  styleUrls: ['./listado.component.css']
})
export class ListadoComponent implements OnInit {

  table:string = ''
  dataSource:any = new MatTableDataSource([])
  displayedColumns: string[] = [];

  constructor(
    private activeRoute: ActivatedRoute,
    private _liveAnnouncer: LiveAnnouncer,
    private dataService: DataService,
    private router: Router,
    private toastr: ToastrService,
  ) {
  }

  @ViewChild(MatPaginator) paginator: MatPaginator;
  @ViewChild(MatSort) sort: MatSort;

  ngAfterViewInit() {
    this.dataSource.sort = this.sort;
    this.dataSource.paginator = this.paginator;
  }

  ngOnInit(): void {
    this.activeRoute.params.subscribe((params:any) => {
      this.table = params.tabla
      this.dataService.getData(this.table).subscribe({
        next: (data:any) => {
          this.dataSource = new MatTableDataSource(data);
          this.displayedColumns = this.getTableHeader(data);
        }
      })
    })
  }

  getTableHeader(data:any):string[]{
    const arr =  data.reduce((prev:string[], obj: any) => {
      Object.keys(obj).forEach((key:string) => {
        if(!prev.includes(key)) prev.push(key)
      })
      return prev
    }, [])
    if(arr.length > 0) arr.push('btn')
    if(arr.includes('foto_fk')) {
      const index = arr.indexOf('foto_fk');
      if (index !== -1) {
        arr.splice(index, 1);
      }
    }
    return arr
  }

  applyFilter(event: Event) {
    const filterValue = (event.target as HTMLInputElement).value;
    this.dataSource.filter = filterValue.trim().toLowerCase();
  }

  announceSortChange(sortState: Sort) {
    if (sortState.direction) {
      this._liveAnnouncer.announce(`Sorted ${sortState.direction}ending`);
    } else {
      this._liveAnnouncer.announce('Sorting cleared');
    }
  }

  deleteRowData(id:number){
    this.dataService.deleteRowData(this.table, id).subscribe({
      next: (result:any) => {
        if(result.ok){
          this.toastr.success(result.msg, 'Éxito', {positionClass: 'toast-bottom-right'})
          this.router.navigate(['/project']).then(() => {
            this.router.navigate([`/project/listado/${this.table}`])
          })
        }
      },
      error: (result) => {
        this.toastr.error(result.msg, 'Error', {positionClass: 'toast-bottom-right'})
      }
    })
  }

  goToAdd(id:number | undefined = undefined){
    if(id) this.router.navigate([`project/add/${this.table}/${id}`])
    else this.router.navigate([`project/add/${this.table}`])
  }

  showPhotos(id:number) {
    this.dataService.getPhotos(id).subscribe({
      next: (result:any) => {
        console.log(result.response)
      }
    })
  }

}
