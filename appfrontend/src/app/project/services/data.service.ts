import { HttpClient, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { map, Observable } from 'rxjs';
import { AuthService } from 'src/app/auth/services/auth.service';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class DataService {

  private baseUrl: string = environment.baseUrl

  constructor(
    private http: HttpClient,
    private authService: AuthService
  ) { }

  getData(table: string):Observable<any>{
    const params = new HttpParams().set('table', table);
    return this.http.get(`${this.baseUrl}/data`, Object.assign(this.authService.httpOptions, {params})).pipe(
      map((result:any) => {
        if(result.ok) return result.response
        else return []
      }) 
    )
  }

  getDomains(){
    return this.http.get(`${this.baseUrl}/data/domains`, this.authService.httpOptions)
  }

  addData(formData:any) {
    return this.http.post(`${this.baseUrl}/data`, formData, this.authService.httpOptions)
  }

  updateData(formData:any) {
    return this.http.put(`${this.baseUrl}/data`, formData, this.authService.httpOptions)
  }

  getRowData(table:string, id:number){
    return this.http.get(`${this.baseUrl}/data/${table}/${id}`, this.authService.httpOptions)
  }

  deleteRowData(table:string, id:number){
    return this.http.delete(`${this.baseUrl}/data/${table}/${id}`, this.authService.httpOptions)
  }

  addOrUpdate(body:any, files:any, id:number | undefined = undefined) {
    const formData = new FormData();
    formData.append('body', JSON.stringify(body));
    if(files.length > 0) {
      Array.from(files).forEach((file:any) => {
        formData.append('files', file);
      })
    }
    if(id) return this.updateData(formData)
    else return this.addData(formData)
  }

  getPhotos(id:number){
    return this.http.get(`${this.baseUrl}/data/planta/photos/${id}`, this.authService.httpOptions)
  }
}
