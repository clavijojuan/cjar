import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { AuthService } from '../../services/auth.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  userProperties: any = {
    usuario: '',
    contrasena: '',
  };

  hide = true;

  constructor(
    private authService: AuthService,
    private router: Router,
    private toastr: ToastrService,
  ) { 
  }

  ngOnInit(): void {
  }

  login(event:any){
    event.preventDefault();
    this.authService.login(this.userProperties).subscribe({
      next: (response:any) => {
        if(response.ok){
          this.toastr.success('Inicio de sesión exitoso', 'Éxito', {positionClass: 'toast-bottom-right'})
          this.router.navigate(['project'])
        }
      }
    })


  }

}
