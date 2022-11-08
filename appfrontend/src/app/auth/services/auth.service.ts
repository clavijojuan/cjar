import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { catchError, map, Observable, of, Subject, tap } from 'rxjs';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  private baseUrl: string = environment.baseUrl
  private auth:any = {}
  private token:string = ''

  constructor(
    private http: HttpClient
  ) { }

  get getAuth():any {
    return this.auth;
  }

  get httpOptions(): any {
    const headers = new HttpHeaders().set('x-token', JSON.parse(localStorage.getItem('token')!) || '');
    return { headers, responseType: 'json' }
  }

  getAuthProperty(property:string):any {
    if(this.auth.hasOwnProperty(property)) return this.auth[property];
    else return undefined
  }

  login(body:any){
    return this.http.post(`${this.baseUrl}/auth`, body).pipe(

      tap((data:any) => {
        console.log(data)
        this.auth = data.response;
        this.token = data.token;
        localStorage.setItem('token',JSON.stringify(data.token));
      }),
      catchError((err) => {  throw "No se pudo iniciar sesión" })

    )
  }

  openedSession():Observable<boolean> {
    if(this.token && this.auth) return of(true);
    if(!localStorage.getItem('token')) return of(false);
    else {
      return this.http.get<any>(`${this.baseUrl}/auth/renew`, this.httpOptions).pipe(
          tap((data:any) => {
            this.auth = data.response;
            this.token = data.token;
          }),
          map((resp:any) => {
            return resp["ok"]
          }),
          catchError((err) => {  return of(false) })
      )
    }
  }

  logout(){
    this.token = '';
    localStorage.removeItem('token');
    this.auth = {};
  }

}
