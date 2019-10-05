import { Component, OnInit,ElementRef,AfterViewInit  } from '@angular/core';
import * as $ from 'jquery';
import {Router} from '@angular/router';
import { isNull } from '@angular/compiler/src/output/output_ast';
import { Session } from 'protractor';
import { FormGroup, FormBuilder, Validators,ReactiveFormsModule  } from '@angular/forms';
//import { REACTIVE_FORM_DIRECTIVES } from '@angular/forms';

@Component({
    selector: 'app-signup',
    templateUrl: './signup.component.html',
    styleUrls: ['./signup.component.scss']
})
export class SignupComponent implements OnInit {
    test : Date = new Date();
    focus;
    focus1;
    
    form:FormGroup;   
    StudentEmail :string = "Student";
    StaffEmail :string = "Staff";
    Password : string = "TestPassword";
    error:string = "Values not Matching";

    

    constructor(private router: Router,
                private fb:FormBuilder) 
                {
                    this.form = this.fb.group({
                    email: ['',Validators.required],
                    password: ['',Validators.required]
                    }); 
                 }

    ngOnInit(){
        // window.alert('Login Click!');
        // let sessionvar = localStorage.getItem('Email');
        // if(sessionvar != '')
        // {
        //     this.router.navigate(['./landing'])
        // }
        // else{
        //     this.router.navigate(['./'])
        // }
    }
    ngAfterViewInit()
    {
        // $('.navbar').remove();
        // $('.footer').remove();
        $("nav").hide();
        $("footer").hide();
        // $('html').attr('style','overflow:hidden');
    }
    
    
    LoginClick(FormEmail:string,FormPassword:string) : void { 
        const val = this.form.value;
        if((val.email == this.StudentEmail || val.email == this.StaffEmail) && val.password == this.Password)
        {
            console.log(val.password);
            this.router.navigate(['./landing']);
        }
        // if((this.StudentEmail==FormEmail || this.StaffEmail==FormEmail) && this.Password==FormPassword)
        // {
        //     console.log(this.Password);
        //     this.router.navigate(['./landing'])
        // }    
        else
        {
            console.log(this.error);
        }  
        let s:string = "LoginLog"
        console.log(s);
        localStorage.setItem('Email',val.email);
        let ssvar:string = localStorage.getItem('Email');
        console.log(ssvar);
    }
    Logoutclick(){
        localStorage.clear();
        this.router.navigate(['./']);
    }
    // LoginClick() : void
    // {
    //     window.alert('Login Click!');
    // }
    
}
